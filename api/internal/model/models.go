package model

import (
	"encoding/json"
	"time"
)

type User struct {
	ID           int64     `json:"id"`
	Email        string    `json:"email"`
	PasswordHash string    `json:"-"`
	DisplayName  string    `json:"display_name"`
	CreatedAt    time.Time `json:"created_at"`
}

type Topic struct {
	ID         int64  `json:"id"`
	Subject    string `json:"subject"`
	Name       string `json:"name"`
	OrderIndex int    `json:"order_index"`
}

type Subtopic struct {
	ID         int64  `json:"id"`
	TopicID    int64  `json:"topic_id"`
	Name       string `json:"name"`
	OrderIndex int    `json:"order_index"`
}

type Question struct {
	ID            int64            `json:"id"`
	SubtopicID    int64            `json:"subtopic_id"`
	Type          string           `json:"type"`
	Stem          string           `json:"stem"`
	Choices       *json.RawMessage `json:"choices,omitempty"`
	CorrectAnswer string           `json:"-"`
	Explanation   string           `json:"-"`
	Difficulty    int              `json:"difficulty"`
}

type Attempt struct {
	ID         int64     `json:"id"`
	UserID     int64     `json:"user_id"`
	QuestionID int64     `json:"question_id"`
	IsCorrect  bool      `json:"is_correct"`
	AnsweredAt time.Time `json:"answered_at"`
}

type Review struct {
	ID           int64     `json:"id"`
	UserID       int64     `json:"user_id"`
	SubtopicID   int64     `json:"subtopic_id"`
	Ease         float64   `json:"ease"`
	IntervalDays int       `json:"interval_days"`
	DueAt        time.Time `json:"due_at"`
	Reps         int       `json:"reps"`
}

// TopicWithSubtopics is used for the /api/topics response.
type TopicWithSubtopics struct {
	Topic
	Subtopics []Subtopic `json:"subtopics"`
}

// SubtopicProgress is used for the dashboard response.
type SubtopicProgress struct {
	SubtopicID   int64   `json:"subtopic_id"`
	SubtopicName string  `json:"subtopic_name"`
	TopicName    string  `json:"topic_name"`
	TotalAttempts int    `json:"total_attempts"`
	CorrectCount int     `json:"correct_count"`
	MasteryPct   float64 `json:"mastery_pct"`
	IsDueToday   bool    `json:"is_due_today"`
}

type DashboardResponse struct {
	Subtopics    []SubtopicProgress `json:"subtopics"`
	DueCount     int                `json:"due_count"`
	CurrentStreak int               `json:"current_streak"`
}

type AnswerRequest struct {
	QuestionID int64  `json:"question_id"`
	Answer     string `json:"answer"`
}

type AnswerResponse struct {
	IsCorrect   bool    `json:"is_correct"`
	Explanation string  `json:"explanation"`
	UpdatedReview *Review `json:"updated_review"`
}
