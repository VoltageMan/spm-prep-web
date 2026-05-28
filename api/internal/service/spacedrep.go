package service

import (
	"math"
	"time"

	"github.com/spm-prep/api/internal/model"
)

// Simplified SM-2 spaced repetition algorithm.
//
// On correct answer:
//   reps += 1
//   if reps == 1: interval = 1 day
//   if reps == 2: interval = 3 days
//   if reps >= 3: interval = round(interval * ease)
//   ease = max(1.3, ease + 0.1)
//   due_at = now + interval days
//
// On wrong answer:
//   reps = 0
//   interval = 1 day
//   ease = max(1.3, ease - 0.2)
//   due_at = now + 1 day
//
// Default ease for new subtopics: 2.5

const (
	DefaultEase = 2.5
	MinEase     = 1.3
)

// UpdateReview applies the SM-2 update to a review. It is a pure function:
// given the current review state, whether the answer was correct, and the
// current time, it returns the updated review. The caller persists the result.
func UpdateReview(rev model.Review, correct bool, now time.Time) model.Review {
	if correct {
		rev.Reps++
		switch rev.Reps {
		case 1:
			rev.IntervalDays = 1
		case 2:
			rev.IntervalDays = 3
		default:
			rev.IntervalDays = int(math.Round(float64(rev.IntervalDays) * rev.Ease))
		}
		rev.Ease = math.Max(MinEase, rev.Ease+0.1)
	} else {
		rev.Reps = 0
		rev.IntervalDays = 1
		rev.Ease = math.Max(MinEase, rev.Ease-0.2)
	}
	rev.DueAt = now.Add(time.Duration(rev.IntervalDays) * 24 * time.Hour)
	return rev
}

// NewReview creates a fresh review for a user+subtopic, prior to any SM-2 update.
func NewReview(userID, subtopicID int64) model.Review {
	return model.Review{
		UserID:       userID,
		SubtopicID:   subtopicID,
		Ease:         DefaultEase,
		IntervalDays: 0,
		Reps:         0,
		DueAt:        time.Now(),
	}
}
