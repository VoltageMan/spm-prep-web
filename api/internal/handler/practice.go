package handler

import (
	"net/http"

	"github.com/spm-prep/api/internal/auth"
	"github.com/spm-prep/api/internal/model"
	"github.com/spm-prep/api/internal/service"
)

type PracticeHandler struct {
	svc *service.PracticeService
}

func NewPracticeHandler(svc *service.PracticeService) *PracticeHandler {
	return &PracticeHandler{svc: svc}
}

func (h *PracticeHandler) NextQuestion(w http.ResponseWriter, r *http.Request) {
	userID, ok := auth.UserIDFromContext(r.Context())
	if !ok {
		writeError(w, http.StatusInternalServerError, "auth middleware misconfigured")
		return
	}
	q, err := h.svc.NextQuestion(r.Context(), userID)
	if err != nil {
		writeError(w, http.StatusNotFound, err.Error())
		return
	}
	writeJSON(w, http.StatusOK, q)
}

func (h *PracticeHandler) SubmitAnswer(w http.ResponseWriter, r *http.Request) {
	userID, ok := auth.UserIDFromContext(r.Context())
	if !ok {
		writeError(w, http.StatusInternalServerError, "auth middleware misconfigured")
		return
	}

	var req model.AnswerRequest
	if err := decodeJSON(r, &req); err != nil {
		writeError(w, http.StatusBadRequest, "format JSON tidak sah")
		return
	}
	if req.QuestionID == 0 {
		writeError(w, http.StatusBadRequest, "question_id diperlukan")
		return
	}
	if req.Answer == "" {
		writeError(w, http.StatusBadRequest, "jawapan diperlukan")
		return
	}

	resp, err := h.svc.SubmitAnswer(r.Context(), userID, req)
	if err != nil {
		writeError(w, http.StatusBadRequest, err.Error())
		return
	}
	writeJSON(w, http.StatusOK, resp)
}
