package service

import "testing"

func TestSelectSubtopic(t *testing.T) {
	tests := []struct {
		name   string
		scores []SubtopicScore
		want   int64
	}{
		{
			name:   "empty returns 0",
			scores: nil,
			want:   0,
		},
		{
			name: "due subtopics — picks lowest accuracy",
			scores: []SubtopicScore{
				{SubtopicID: 1, IsDue: true, RecentAccuracy: 0.8, HasReview: true},
				{SubtopicID: 2, IsDue: true, RecentAccuracy: 0.3, HasReview: true},
				{SubtopicID: 3, IsDue: false, RecentAccuracy: 0.1, HasReview: true},
			},
			want: 2,
		},
		{
			name: "nothing due — picks new subtopic by order_index",
			scores: []SubtopicScore{
				{SubtopicID: 1, IsDue: false, HasReview: true, OrderIndex: 1},
				{SubtopicID: 2, IsDue: false, HasReview: false, OrderIndex: 5},
				{SubtopicID: 3, IsDue: false, HasReview: false, OrderIndex: 3},
			},
			want: 3,
		},
		{
			name: "all reviewed, nothing due — picks lowest accuracy",
			scores: []SubtopicScore{
				{SubtopicID: 1, IsDue: false, HasReview: true, RecentAccuracy: 0.9},
				{SubtopicID: 2, IsDue: false, HasReview: true, RecentAccuracy: 0.5},
				{SubtopicID: 3, IsDue: false, HasReview: true, RecentAccuracy: 0.7},
			},
			want: 2,
		},
		{
			name: "single due subtopic is chosen",
			scores: []SubtopicScore{
				{SubtopicID: 5, IsDue: true, RecentAccuracy: 1.0, HasReview: true},
				{SubtopicID: 6, IsDue: false, HasReview: false, OrderIndex: 1},
			},
			want: 5,
		},
		{
			name: "due with zero accuracy beats due with some accuracy",
			scores: []SubtopicScore{
				{SubtopicID: 1, IsDue: true, RecentAccuracy: 0.5, HasReview: true},
				{SubtopicID: 2, IsDue: true, RecentAccuracy: 0.0, HasReview: true},
			},
			want: 2,
		},
		{
			name: "fresh user — all new, picks first by order_index",
			scores: []SubtopicScore{
				{SubtopicID: 3, HasReview: false, OrderIndex: 3},
				{SubtopicID: 1, HasReview: false, OrderIndex: 1},
				{SubtopicID: 2, HasReview: false, OrderIndex: 2},
			},
			want: 1,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := SelectSubtopic(tt.scores)
			if got != tt.want {
				t.Errorf("SelectSubtopic() = %d, want %d", got, tt.want)
			}
		})
	}
}
