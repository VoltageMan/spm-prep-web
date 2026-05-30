package repository

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/spm-prep/api/internal/model"
)

type ReviewRepo struct {
	db *pgxpool.Pool
}

func NewReviewRepo(db *pgxpool.Pool) *ReviewRepo {
	return &ReviewRepo{db: db}
}

func (r *ReviewRepo) GetByUserAndSubtopic(ctx context.Context, userID, subtopicID int64) (*model.Review, error) {
	rev := &model.Review{}
	err := r.db.QueryRow(ctx,
		`SELECT id, user_id, subtopic_id, ease, interval_days, due_at, reps, updated_at
		 FROM reviews WHERE user_id = $1 AND subtopic_id = $2`,
		userID, subtopicID,
	).Scan(&rev.ID, &rev.UserID, &rev.SubtopicID, &rev.Ease, &rev.IntervalDays, &rev.DueAt, &rev.Reps, &rev.UpdatedAt)
	return rev, err
}

func (r *ReviewRepo) Upsert(ctx context.Context, rev *model.Review) (*model.Review, error) {
	out := &model.Review{}
	err := r.db.QueryRow(ctx,
		`INSERT INTO reviews (user_id, subtopic_id, ease, interval_days, due_at, reps)
		 VALUES ($1, $2, $3, $4, $5, $6)
		 ON CONFLICT (user_id, subtopic_id)
		 DO UPDATE SET ease = $3, interval_days = $4, due_at = $5, reps = $6, updated_at = now()
		 RETURNING id, user_id, subtopic_id, ease, interval_days, due_at, reps, updated_at`,
		rev.UserID, rev.SubtopicID, rev.Ease, rev.IntervalDays, rev.DueAt, rev.Reps,
	).Scan(&out.ID, &out.UserID, &out.SubtopicID, &out.Ease, &out.IntervalDays, &out.DueAt, &out.Reps, &out.UpdatedAt)
	return out, err
}

// DueSubtopics returns subtopic IDs with reviews due on or before now, ordered by due_at.
func (r *ReviewRepo) DueSubtopics(ctx context.Context, userID int64) ([]int64, error) {
	rows, err := r.db.Query(ctx,
		`SELECT subtopic_id FROM reviews
		 WHERE user_id = $1 AND due_at <= now()
		 ORDER BY due_at ASC`,
		userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var ids []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		ids = append(ids, id)
	}
	return ids, nil
}

// DueCountToday returns how many subtopics are due today for the user.
func (r *ReviewRepo) DueCountToday(ctx context.Context, userID int64) (int, error) {
	var count int
	err := r.db.QueryRow(ctx,
		`SELECT COUNT(*) FROM reviews WHERE user_id = $1 AND due_at <= now()`,
		userID).Scan(&count)
	return count, err
}

// AllUserSubtopicsDue returns subtopic IDs that are due, for dashboard.
func (r *ReviewRepo) AllUserDueSubtopicIDs(ctx context.Context, userID int64) (map[int64]bool, error) {
	rows, err := r.db.Query(ctx,
		`SELECT subtopic_id FROM reviews WHERE user_id = $1 AND due_at <= now()`,
		userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	m := map[int64]bool{}
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		m[id] = true
	}
	return m, nil
}

// ReviewedSubtopicIDs returns all subtopic IDs the user has a review row for.
func (r *ReviewRepo) ReviewedSubtopicIDs(ctx context.Context, userID int64) (map[int64]bool, error) {
	rows, err := r.db.Query(ctx,
		`SELECT subtopic_id FROM reviews WHERE user_id = $1`, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	m := map[int64]bool{}
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		m[id] = true
	}
	return m, nil
}
