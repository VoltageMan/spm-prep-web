package handler

import (
	"net/http"

	"github.com/spm-prep/api/internal/auth"
	"github.com/spm-prep/api/internal/service"
)

type DashboardHandler struct {
	svc *service.PracticeService
}

func NewDashboardHandler(svc *service.PracticeService) *DashboardHandler {
	return &DashboardHandler{svc: svc}
}

func (h *DashboardHandler) Dashboard(w http.ResponseWriter, r *http.Request) {
	userID := auth.UserIDFromContext(r.Context())
	data, err := h.svc.Dashboard(r.Context(), userID)
	if err != nil {
		writeError(w, http.StatusInternalServerError, "gagal memuatkan papan pemuka")
		return
	}
	writeJSON(w, http.StatusOK, data)
}

func (h *DashboardHandler) Topics(w http.ResponseWriter, r *http.Request) {
	topics, err := h.svc.Topics(r.Context())
	if err != nil {
		writeError(w, http.StatusInternalServerError, "gagal memuatkan topik")
		return
	}
	writeJSON(w, http.StatusOK, topics)
}
