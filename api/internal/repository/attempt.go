package repository

import (
	"context"
	"errors"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

type AttemptRepo struct {
	db *pgxpool.Pool
}

func NewAttemptRepo(db *pgxpool.Pool) *AttemptRepo {
	return &AttemptRepo{db: db}
}

func (r *AttemptRepo) Create(ctx context.Context, userID, questionID int64, isCorrect bool) error {
	_, err := r.db.Exec(ctx,
		`INSERT INTO attempts (user_id, question_id, is_correct) VALUES ($1, $2, $3)`,
		userID, questionID, isCorrect)
	return err
}

// RecentQuestionIDs returns the IDs of the last N distinct questions answered by the user,
// ordered by most recent first.
func (r *AttemptRepo) RecentQuestionIDs(ctx context.Context, userID int64, limit int) ([]int64, error) {
	rows, err := r.db.Query(ctx,
		`SELECT question_id FROM (
		   SELECT DISTINCT ON (question_id) question_id, answered_at
		   FROM attempts WHERE user_id = $1
		   ORDER BY question_id, answered_at DESC
		 ) sub
		 ORDER BY answered_at DESC
		 LIMIT $2`,
		userID, limit)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	ids := []int64{}
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		ids = append(ids, id)
	}
	return ids, nil
}

// SubtopicAccuracy returns (correct, total) for a user's last N attempts in a subtopic.
func (r *AttemptRepo) SubtopicAccuracy(ctx context.Context, userID, subtopicID int64, lastN int) (correct, total int, err error) {
	err = r.db.QueryRow(ctx,
		`SELECT
		   COALESCE(SUM(CASE WHEN a.is_correct THEN 1 ELSE 0 END), 0),
		   COUNT(*)
		 FROM (
		   SELECT a.is_correct
		   FROM attempts a
		   JOIN questions q ON q.id = a.question_id
		   WHERE a.user_id = $1 AND q.subtopic_id = $2
		   ORDER BY a.answered_at DESC
		   LIMIT $3
		 ) a`,
		userID, subtopicID, lastN,
	).Scan(&correct, &total)
	return
}

// AllSubtopicStats returns overall accuracy per subtopic for a user (all attempts, not windowed).
func (r *AttemptRepo) AllSubtopicStats(ctx context.Context, userID int64) ([]SubtopicStat, error) {
	rows, err := r.db.Query(ctx,
		`SELECT q.subtopic_id,
		        COUNT(*) AS total,
		        SUM(CASE WHEN a.is_correct THEN 1 ELSE 0 END) AS correct
		 FROM attempts a
		 JOIN questions q ON q.id = a.question_id
		 WHERE a.user_id = $1
		 GROUP BY q.subtopic_id`,
		userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var stats []SubtopicStat
	for rows.Next() {
		var s SubtopicStat
		if err := rows.Scan(&s.SubtopicID, &s.Total, &s.Correct); err != nil {
			return nil, err
		}
		stats = append(stats, s)
	}
	return stats, nil
}

// CurrentStreak returns the number of consecutive calendar days (UTC) ending today
// TODO: thread the user's timezone through so Malaysian users (UTC+8) don't see the streak
// flip a day early/late near midnight.
// on which the user submitted at least one attempt. A day with zero attempts breaks
// the streak; if today has no attempts the result is 0.
func (r *AttemptRepo) CurrentStreak(ctx context.Context, userID int64) (int, error) {
	var streak int
	err := r.db.QueryRow(ctx,
		`WITH days AS (
		   SELECT DISTINCT answered_at::date AS d FROM attempts WHERE user_id = $1
		 ),
		 grouped AS (
		   SELECT d, d - (ROW_NUMBER() OVER (ORDER BY d))::int * INTERVAL '1 day' AS grp
		   FROM days
		 ),
		 latest AS (
		   SELECT grp, MAX(d) AS last_day FROM grouped GROUP BY grp ORDER BY last_day DESC LIMIT 1
		 )
		 SELECT CASE WHEN l.last_day = CURRENT_DATE THEN COUNT(*) ELSE 0 END
		 FROM grouped g JOIN latest l ON g.grp = l.grp
		 GROUP BY l.last_day`,
		userID).Scan(&streak)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return 0, nil
		}
		return 0, err
	}
	return streak, nil
}

type SubtopicStat struct {
	SubtopicID int64
	Total      int
	Correct    int
}
