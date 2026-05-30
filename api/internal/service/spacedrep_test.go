package service

import (
	"testing"
	"time"

	"github.com/spm-prep/api/internal/model"
)

func TestUpdateReview(t *testing.T) {
	now := time.Date(2026, 1, 1, 12, 0, 0, 0, time.UTC)

	tests := []struct {
		name            string
		input           model.Review
		correct         bool
		wantReps        int
		wantInterval    int
		wantEaseApprox  float64
		wantDueDaysFrom int // days from now
	}{
		{
			name:            "first correct answer on new subtopic",
			input:           model.Review{Ease: 2.5, IntervalDays: 0, Reps: 0},
			correct:         true,
			wantReps:        1,
			wantInterval:    1,
			wantEaseApprox:  2.6,
			wantDueDaysFrom: 1,
		},
		{
			name:            "second correct answer",
			input:           model.Review{Ease: 2.6, IntervalDays: 1, Reps: 1},
			correct:         true,
			wantReps:        2,
			wantInterval:    3,
			wantEaseApprox:  2.7,
			wantDueDaysFrom: 3,
		},
		{
			name:            "third correct answer — interval multiplied by ease",
			input:           model.Review{Ease: 2.7, IntervalDays: 3, Reps: 2},
			correct:         true,
			wantReps:        3,
			wantInterval:    8, // round(3 * 2.7) = 8
			wantEaseApprox:  2.8,
			wantDueDaysFrom: 8,
		},
		{
			name:            "fourth correct — continues scaling",
			input:           model.Review{Ease: 2.8, IntervalDays: 8, Reps: 3},
			correct:         true,
			wantReps:        4,
			wantInterval:    22, // round(8 * 2.8) = 22
			wantEaseApprox:  2.9,
			wantDueDaysFrom: 22,
		},
		{
			name:            "wrong answer resets",
			input:           model.Review{Ease: 2.7, IntervalDays: 8, Reps: 3},
			correct:         false,
			wantReps:        0,
			wantInterval:    1,
			wantEaseApprox:  2.5,
			wantDueDaysFrom: 1,
		},
		{
			name:            "wrong answer on fresh review",
			input:           model.Review{Ease: 2.5, IntervalDays: 0, Reps: 0},
			correct:         false,
			wantReps:        0,
			wantInterval:    1,
			wantEaseApprox:  2.3,
			wantDueDaysFrom: 1,
		},
		{
			name:            "wrong answer — ease cannot drop below 1.3",
			input:           model.Review{Ease: 1.4, IntervalDays: 3, Reps: 2},
			correct:         false,
			wantReps:        0,
			wantInterval:    1,
			wantEaseApprox:  1.3, // max(1.3, 1.4 - 0.2) = 1.3 (not 1.2)
			wantDueDaysFrom: 1,
		},
		{
			name:            "wrong answer — ease already at minimum stays 1.3",
			input:           model.Review{Ease: 1.3, IntervalDays: 3, Reps: 2},
			correct:         false,
			wantReps:        0,
			wantInterval:    1,
			wantEaseApprox:  1.3, // max(1.3, 1.3 - 0.2) = max(1.3, 1.1) = 1.3
			wantDueDaysFrom: 1,
		},
		{
			name:            "correct at minimum ease",
			input:           model.Review{Ease: 1.3, IntervalDays: 1, Reps: 0},
			correct:         true,
			wantReps:        1,
			wantInterval:    1,
			wantEaseApprox:  1.4,
			wantDueDaysFrom: 1,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := UpdateReview(tt.input, tt.correct, now)

			if got.Reps != tt.wantReps {
				t.Errorf("Reps = %d, want %d", got.Reps, tt.wantReps)
			}
			if got.IntervalDays != tt.wantInterval {
				t.Errorf("IntervalDays = %d, want %d", got.IntervalDays, tt.wantInterval)
			}
			// Float comparison with tolerance
			if diff := got.Ease - tt.wantEaseApprox; diff > 0.01 || diff < -0.01 {
				t.Errorf("Ease = %.2f, want ≈%.2f", got.Ease, tt.wantEaseApprox)
			}
			wantDue := now.Add(time.Duration(tt.wantDueDaysFrom) * 24 * time.Hour)
			if !got.DueAt.Equal(wantDue) {
				t.Errorf("DueAt = %v, want %v", got.DueAt, wantDue)
			}
		})
	}
}
