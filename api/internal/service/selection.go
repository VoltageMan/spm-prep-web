package service

// Named constants for question selection tuning.
const (
	// RecentAccuracyWindow is the number of recent attempts per subtopic
	// used to compute "recent accuracy" for prioritization.
	RecentAccuracyWindow = 10

	// RecentQuestionExcludeCount is the number of most-recently-shown
	// questions to avoid re-serving to the user.
	RecentQuestionExcludeCount = 5
)

// SubtopicScore holds the data needed to rank which subtopic to serve next.
type SubtopicScore struct {
	SubtopicID     int64
	IsDue          bool    // has a review row with due_at <= now
	RecentAccuracy float64 // correct / total over last RecentAccuracyWindow attempts
	AttemptCount   int     // total attempts in this subtopic
	OrderIndex     int     // subtopic's curriculum order
	HasReview      bool    // whether the user has ever reviewed this subtopic
}

// SelectSubtopic picks the best subtopic to serve next, given scored subtopics.
// This is a pure function — no DB access.
//
// Priority order:
// 1. Due subtopics, sorted by lowest recent accuracy.
// 2. New subtopics (no review row), sorted by order_index.
// 3. If everything is reviewed and nothing due, pick lowest mastery.
//
// Returns the subtopic ID, or 0 if the slice is empty.
func SelectSubtopic(scores []SubtopicScore) int64 {
	if len(scores) == 0 {
		return 0
	}

	// Priority 1: due subtopics, lowest accuracy first
	var bestDue *SubtopicScore
	for i := range scores {
		s := &scores[i]
		if !s.IsDue {
			continue
		}
		if bestDue == nil || s.RecentAccuracy < bestDue.RecentAccuracy {
			bestDue = s
		}
	}
	if bestDue != nil {
		return bestDue.SubtopicID
	}

	// Priority 2: new subtopics (never reviewed), by order_index
	var bestNew *SubtopicScore
	for i := range scores {
		s := &scores[i]
		if s.HasReview {
			continue
		}
		if bestNew == nil || s.OrderIndex < bestNew.OrderIndex {
			bestNew = s
		}
	}
	if bestNew != nil {
		return bestNew.SubtopicID
	}

	// Priority 3: everything reviewed, nothing due — lowest mastery
	var bestLow *SubtopicScore
	for i := range scores {
		s := &scores[i]
		if bestLow == nil || s.RecentAccuracy < bestLow.RecentAccuracy {
			bestLow = s
		}
	}
	return bestLow.SubtopicID
}
