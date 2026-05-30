package repository

import (
	"context"
	"encoding/json"
	"errors"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/spm-prep/api/internal/model"
)

type QuestionRepo struct {
	db *pgxpool.Pool
}

func NewQuestionRepo(db *pgxpool.Pool) *QuestionRepo {
	return &QuestionRepo{db: db}
}

func (r *QuestionRepo) GetByID(ctx context.Context, id int64) (*model.Question, error) {
	q := &model.Question{}
	var choicesRaw []byte
	err := r.db.QueryRow(ctx,
		`SELECT id, subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty
		 FROM questions WHERE id = $1`, id,
	).Scan(&q.ID, &q.SubtopicID, &q.Type, &q.Stem, &choicesRaw, &q.CorrectAnswer, &q.Explanation, &q.Difficulty)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrNotFound
		}
		return nil, err
	}
	if choicesRaw != nil {
		raw := json.RawMessage(choicesRaw)
		q.Choices = &raw
	}
	return q, nil
}

// GetBySubtopicForUser returns questions in a subtopic, annotated with last-attempt time.
// excludeIDs is the list of recently-shown question IDs to deprioritize.
func (r *QuestionRepo) GetBySubtopicForUser(ctx context.Context, userID, subtopicID int64, excludeIDs []int64) (*model.Question, error) {
	// Strategy:
	// (a) Prefer questions not in excludeIDs that user hasn't attempted.
	// (b) Fallback: question with oldest last-attempt, not in excludeIDs.
	// (c) Final fallback: question with oldest last-attempt (any).
	if excludeIDs == nil {
		excludeIDs = []int64{}
	}

	q := &model.Question{}
	var choicesRaw []byte

	// (a) Unseen question not recently shown
	err := r.db.QueryRow(ctx,
		`SELECT q.id, q.subtopic_id, q.type, q.stem, q.choices_json, q.correct_answer, q.explanation, q.difficulty
		 FROM questions q
		 WHERE q.subtopic_id = $1
		   AND q.id != ALL($3)
		   AND NOT EXISTS (SELECT 1 FROM attempts a WHERE a.question_id = q.id AND a.user_id = $2)
		 ORDER BY q.difficulty ASC, q.id ASC
		 LIMIT 1`,
		subtopicID, userID, excludeIDs,
	).Scan(&q.ID, &q.SubtopicID, &q.Type, &q.Stem, &choicesRaw, &q.CorrectAnswer, &q.Explanation, &q.Difficulty)
	if err == nil {
		if choicesRaw != nil {
			raw := json.RawMessage(choicesRaw)
			q.Choices = &raw
		}
		return q, nil
	}

	// (b) Oldest attempted question, not recently shown
	err = r.db.QueryRow(ctx,
		`SELECT q.id, q.subtopic_id, q.type, q.stem, q.choices_json, q.correct_answer, q.explanation, q.difficulty
		 FROM questions q
		 JOIN (
		   SELECT question_id, MAX(answered_at) AS last_at
		   FROM attempts WHERE user_id = $2
		   GROUP BY question_id
		 ) a ON a.question_id = q.id
		 WHERE q.subtopic_id = $1
		   AND q.id != ALL($3)
		 ORDER BY a.last_at ASC
		 LIMIT 1`,
		subtopicID, userID, excludeIDs,
	).Scan(&q.ID, &q.SubtopicID, &q.Type, &q.Stem, &choicesRaw, &q.CorrectAnswer, &q.Explanation, &q.Difficulty)
	if err == nil {
		if choicesRaw != nil {
			raw := json.RawMessage(choicesRaw)
			q.Choices = &raw
		}
		return q, nil
	}

	// (c) Final fallback — oldest attempted, even if recently shown (but never same as last)
	err = r.db.QueryRow(ctx,
		`SELECT q.id, q.subtopic_id, q.type, q.stem, q.choices_json, q.correct_answer, q.explanation, q.difficulty
		 FROM questions q
		 LEFT JOIN (
		   SELECT question_id, MAX(answered_at) AS last_at
		   FROM attempts WHERE user_id = $2
		   GROUP BY question_id
		 ) a ON a.question_id = q.id
		 WHERE q.subtopic_id = $1
		 ORDER BY a.last_at ASC NULLS FIRST, q.difficulty ASC
		 LIMIT 1`,
		subtopicID, userID,
	).Scan(&q.ID, &q.SubtopicID, &q.Type, &q.Stem, &choicesRaw, &q.CorrectAnswer, &q.Explanation, &q.Difficulty)
	if err != nil {
		return nil, err
	}
	if choicesRaw != nil {
		raw := json.RawMessage(choicesRaw)
		q.Choices = &raw
	}
	return q, nil
}

// GetAllTopicsWithSubtopics returns topics with nested subtopics.
func (r *QuestionRepo) GetAllTopicsWithSubtopics(ctx context.Context) ([]model.TopicWithSubtopics, error) {
	rows, err := r.db.Query(ctx,
		`SELECT t.id, t.subject, t.name, t.order_index,
		        s.id, s.topic_id, s.name, s.order_index
		 FROM topics t
		 LEFT JOIN subtopics s ON s.topic_id = t.id
		 ORDER BY t.order_index, s.order_index`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	topicMap := map[int64]*model.TopicWithSubtopics{}
	var order []int64
	for rows.Next() {
		var t model.Topic
		var s model.Subtopic
		if err := rows.Scan(&t.ID, &t.Subject, &t.Name, &t.OrderIndex,
			&s.ID, &s.TopicID, &s.Name, &s.OrderIndex); err != nil {
			return nil, err
		}
		if _, ok := topicMap[t.ID]; !ok {
			topicMap[t.ID] = &model.TopicWithSubtopics{Topic: t, Subtopics: []model.Subtopic{}}
			order = append(order, t.ID)
		}
		topicMap[t.ID].Subtopics = append(topicMap[t.ID].Subtopics, s)
	}
	result := make([]model.TopicWithSubtopics, 0, len(order))
	for _, id := range order {
		result = append(result, *topicMap[id])
	}
	return result, nil
}
