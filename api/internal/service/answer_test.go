package service

import "testing"

func TestCheckAnswer(t *testing.T) {
	tests := []struct {
		name      string
		qType     string
		correct   string
		user      string
		want      bool
	}{
		// MCQ
		{"mcq exact match", "mcq", "C", "C", true},
		{"mcq case insensitive", "mcq", "B", "b", true},
		{"mcq wrong", "mcq", "A", "D", false},
		{"mcq with whitespace", "mcq", "A", "  A  ", true},
		{"mcq full choice string", "mcq", "C", "C. 7", true},

		// Numeric short answers
		{"short exact int", "short", "14", "14", true},
		{"short negative", "short", "-12", "-12", true},
		{"short decimal", "short", "0.375", "0.375", true},
		{"short .5 vs 0.5", "short", "0.5", ".5", true},
		{"short with spaces", "short", "60", "  60  ", true},
		{"short wrong", "short", "14", "15", false},
		{"short non-numeric user answer", "short", "14", "fourteen", false},

		// Unknown type
		{"unknown type", "essay", "hello", "hello", false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := CheckAnswer(tt.qType, tt.correct, tt.user)
			if got != tt.want {
				t.Errorf("CheckAnswer(%q, %q, %q) = %v, want %v",
					tt.qType, tt.correct, tt.user, got, tt.want)
			}
		})
	}
}
