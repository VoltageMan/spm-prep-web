package service

import (
	"context"
	"errors"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/spm-prep/api/internal/model"
	"github.com/spm-prep/api/internal/repository"
)

type PracticeService struct {
	questions *repository.QuestionRepo
	attempts  *repository.AttemptRepo
	reviews   *repository.ReviewRepo
}

func NewPracticeService(q *repository.QuestionRepo, a *repository.AttemptRepo, r *repository.ReviewRepo) *PracticeService {
	return &PracticeService{questions: q, attempts: a, reviews: r}
}

// NextQuestion selects the next question for the user using the adaptive algorithm.
func (s *PracticeService) NextQuestion(ctx context.Context, userID int64) (*model.Question, error) {
	// 1. Gather all subtopics
	topics, err := s.questions.GetAllTopicsWithSubtopics(ctx)
	if err != nil {
		return nil, err
	}

	// 2. Get due subtopics and reviewed subtopics for this user
	dueIDs, err := s.reviews.DueSubtopics(ctx, userID)
	if err != nil {
		return nil, err
	}
	dueSet := map[int64]bool{}
	for _, id := range dueIDs {
		dueSet[id] = true
	}

	reviewedSet, err := s.reviews.ReviewedSubtopicIDs(ctx, userID)
	if err != nil {
		return nil, err
	}

	// 3. Build scores for each subtopic
	var scores []SubtopicScore
	for _, t := range topics {
		for _, st := range t.Subtopics {
			correct, total, err := s.attempts.SubtopicAccuracy(ctx, userID, st.ID, RecentAccuracyWindow)
			if err != nil {
				return nil, err
			}
			acc := 0.0
			if total > 0 {
				acc = float64(correct) / float64(total)
			}
			scores = append(scores, SubtopicScore{
				SubtopicID:     st.ID,
				IsDue:          dueSet[st.ID],
				RecentAccuracy: acc,
				AttemptCount:   total,
				OrderIndex:     st.OrderIndex,
				HasReview:      reviewedSet[st.ID],
			})
		}
	}

	// 4. Pick best subtopic
	subtopicID := SelectSubtopic(scores)
	if subtopicID == 0 {
		return nil, errors.New("tiada soalan tersedia")
	}

	// 5. Get recently shown questions to exclude
	recentIDs, err := s.attempts.RecentQuestionIDs(ctx, userID, RecentQuestionExcludeCount)
	if err != nil {
		return nil, err
	}

	// 6. Pick a question from the chosen subtopic
	return s.questions.GetBySubtopicForUser(ctx, userID, subtopicID, recentIDs)
}

// SubmitAnswer checks the answer, records the attempt, and updates spaced repetition.
func (s *PracticeService) SubmitAnswer(ctx context.Context, userID int64, req model.AnswerRequest) (*model.AnswerResponse, error) {
	question, err := s.questions.GetByID(ctx, req.QuestionID)
	if err != nil {
		return nil, errors.New("soalan tidak dijumpai")
	}

	isCorrect := CheckAnswer(question.Type, question.CorrectAnswer, req.Answer)

	// Record attempt
	if err := s.attempts.Create(ctx, userID, req.QuestionID, isCorrect); err != nil {
		return nil, err
	}

	// Lazy-create or fetch existing review for this subtopic
	now := time.Now()
	rev, err := s.reviews.GetByUserAndSubtopic(ctx, userID, question.SubtopicID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			return nil, err
		}
		// First answer in this subtopic — create fresh review, then apply SM-2
		fresh := NewReview(userID, question.SubtopicID)
		updated := UpdateReview(fresh, isCorrect, now)
		rev, err = s.reviews.Upsert(ctx, &updated)
		if err != nil {
			return nil, err
		}
	} else {
		updated := UpdateReview(*rev, isCorrect, now)
		rev, err = s.reviews.Upsert(ctx, &updated)
		if err != nil {
			return nil, err
		}
	}

	return &model.AnswerResponse{
		IsCorrect:     isCorrect,
		Explanation:   question.Explanation,
		UpdatedReview: rev,
	}, nil
}

// Dashboard returns per-subtopic mastery, due count, and streak.
func (s *PracticeService) Dashboard(ctx context.Context, userID int64) (*model.DashboardResponse, error) {
	topics, err := s.questions.GetAllTopicsWithSubtopics(ctx)
	if err != nil {
		return nil, err
	}

	stats, err := s.attempts.AllSubtopicStats(ctx, userID)
	if err != nil {
		return nil, err
	}
	statMap := map[int64]repository.SubtopicStat{}
	for _, st := range stats {
		statMap[st.SubtopicID] = st
	}

	dueSet, err := s.reviews.AllUserDueSubtopicIDs(ctx, userID)
	if err != nil {
		return nil, err
	}

	var progress []model.SubtopicProgress
	dueCount := 0
	for _, t := range topics {
		for _, st := range t.Subtopics {
			stat := statMap[st.ID]
			mastery := 0.0
			if stat.Total > 0 {
				mastery = float64(stat.Correct) / float64(stat.Total) * 100
			}
			isDue := dueSet[st.ID]
			if isDue {
				dueCount++
			}
			progress = append(progress, model.SubtopicProgress{
				SubtopicID:    st.ID,
				SubtopicName:  st.Name,
				TopicName:     t.Name,
				TotalAttempts: stat.Total,
				CorrectCount:  stat.Correct,
				MasteryPct:    mastery,
				IsDueToday:    isDue,
			})
		}
	}

	streak, err := s.attempts.CurrentStreak(ctx, userID)
	if err != nil {
		streak = 0
	}

	return &model.DashboardResponse{
		Subtopics:     progress,
		DueCount:      dueCount,
		CurrentStreak: streak,
	}, nil
}

// Topics returns all topics with subtopics for navigation.
func (s *PracticeService) Topics(ctx context.Context) ([]model.TopicWithSubtopics, error) {
	return s.questions.GetAllTopicsWithSubtopics(ctx)
}
