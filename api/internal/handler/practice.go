package handler

import (
	"errors"
	"log"
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
		switch {
		case errors.Is(err, service.ErrNoQuestionsAvailable):
			writeError(w, http.StatusNotFound, err.Error())
		default:
			log.Printf("next question: unexpected error: %v", err)
			writeError(w, http.StatusInternalServerError, "ralat dalaman")
		}
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
		switch {
		case errors.Is(err, service.ErrQuestionNotFound):
			writeError(w, http.StatusNotFound, err.Error())
		default:
			log.Printf("submit answer: unexpected error: %v", err)
			writeError(w, http.StatusInternalServerError, "ralat dalaman")
		}
		return
	}
	writeJSON(w, http.StatusOK, resp)
}
