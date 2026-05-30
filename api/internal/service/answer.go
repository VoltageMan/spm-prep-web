package service

import (
	"math"
	"strconv"
	"strings"
)

// NumericTolerance is the allowed difference when comparing numeric short answers.
const NumericTolerance = 1e-6

// CheckAnswer determines if the user's answer is correct.
// For MCQ: case-insensitive exact match of the option letter (e.g., "A", "B").
// For short (numeric): parse both to float64 and compare within NumericTolerance.
func CheckAnswer(questionType, correctAnswer, userAnswer string) bool {
	userAnswer = strings.TrimSpace(userAnswer)
	correctAnswer = strings.TrimSpace(correctAnswer)

	switch questionType {
	case "mcq":
		return strings.EqualFold(mcqLetter(userAnswer), mcqLetter(correctAnswer))
	case "short":
		return compareNumeric(correctAnswer, userAnswer)
	default:
		return false
	}
}

func compareNumeric(correct, user string) bool {
	cv, err1 := parseNum(correct)
	uv, err2 := parseNum(user)
	if err1 != nil || err2 != nil {
		return false
	}
	return math.Abs(cv-uv) < NumericTolerance
}

// mcqLetter extracts the option letter from an MCQ answer string.
// Accepts both a bare letter ("C") and a full choice string ("C. answer text").
func mcqLetter(s string) string {
	s = strings.TrimSpace(s)
	if i := strings.IndexAny(s, ". \t"); i >= 0 {
		return s[:i]
	}
	return s
}

// parseNum handles inputs like "0.5", ".5", "-12", "60".
func parseNum(s string) (float64, error) {
	s = strings.TrimSpace(s)
	return strconv.ParseFloat(s, 64)
}
