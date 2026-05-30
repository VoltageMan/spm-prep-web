package service

import (
	"context"
	"strings"
	"unicode/utf8"

	"github.com/spm-prep/api/internal/repository"
)

type ReportService struct {
	reports *repository.ReportRepo
}

func NewReportService(r *repository.ReportRepo) *ReportService {
	return &ReportService{reports: r}
}

func (s *ReportService) Submit(ctx context.Context, questionID int64, userID int64, reason string) error {
	reason = strings.TrimSpace(reason)

	if utf8.RuneCountInString(reason) > 500 {
		return ErrReasonTooLong
	}

	has, err := s.reports.HasOpenFromUser(ctx, questionID, userID)
	if err != nil {
		return err
	}
	if has {
		return ErrAlreadyReported
	}

	var reasonPtr *string
	if reason != "" {
		reasonPtr = &reason
	}

	return s.reports.Create(ctx, questionID, userID, reasonPtr)
}
