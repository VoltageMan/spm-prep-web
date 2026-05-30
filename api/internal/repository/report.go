package repository

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"
)

type ReportRepo struct {
	db *pgxpool.Pool
}

func NewReportRepo(db *pgxpool.Pool) *ReportRepo {
	return &ReportRepo{db: db}
}

func (r *ReportRepo) Create(ctx context.Context, questionID int64, userID int64, reason *string) error {
	_, err := r.db.Exec(ctx,
		`INSERT INTO question_reports (question_id, user_id, reason)
		 VALUES ($1, $2, $3)`,
		questionID, userID, reason,
	)
	return err
}

// HasOpenFromUser returns true only for unresolved reports. Resolved reports do not
// block new submissions from the same user on the same question — this is intentional,
// so users can re-flag a question if it was incorrectly marked as resolved.
func (r *ReportRepo) HasOpenFromUser(ctx context.Context, questionID int64, userID int64) (bool, error) {
	var exists bool
	err := r.db.QueryRow(ctx,
		`SELECT EXISTS(
			SELECT 1 FROM question_reports
			WHERE question_id = $1 AND user_id = $2 AND resolved_at IS NULL
		)`,
		questionID, userID,
	).Scan(&exists)
	if err != nil {
		return false, err
	}
	return exists, nil
}
