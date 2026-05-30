package handler

import (
	"errors"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"

	"github.com/spm-prep/api/internal/auth"
	"github.com/spm-prep/api/internal/service"
)

type ReportHandler struct {
	svc *service.ReportService
}

func NewReportHandler(svc *service.ReportService) *ReportHandler {
	return &ReportHandler{svc: svc}
}

func (h *ReportHandler) Report(w http.ResponseWriter, r *http.Request) {
	userID, ok := auth.UserIDFromContext(r.Context())
	if !ok {
		writeError(w, http.StatusInternalServerError, "auth middleware misconfigured")
		return
	}

	questionID, err := strconv.ParseInt(chi.URLParam(r, "id"), 10, 64)
	if err != nil {
		writeError(w, http.StatusBadRequest, "ID soalan tidak sah")
		return
	}

	var req struct {
		Reason string `json:"reason"`
	}
	if err := decodeJSON(r, &req); err != nil {
		writeError(w, http.StatusBadRequest, "format JSON tidak sah")
		return
	}

	err = h.svc.Submit(r.Context(), questionID, userID, req.Reason)
	if err != nil {
		switch {
		case errors.Is(err, service.ErrReasonTooLong):
			writeError(w, http.StatusBadRequest, err.Error())
		case errors.Is(err, service.ErrAlreadyReported):
			writeError(w, http.StatusConflict, err.Error())
		default:
			log.Printf("report question: unexpected error: %v", err)
			writeError(w, http.StatusInternalServerError, "ralat dalaman")
		}
		return
	}

	w.WriteHeader(http.StatusCreated)
}
