package handler

import (
	"errors"
	"log"
	"net/http"

	"github.com/spm-prep/api/internal/auth"
	"github.com/spm-prep/api/internal/service"
)

type AuthHandler struct {
	svc *service.AuthService
}

func NewAuthHandler(svc *service.AuthService) *AuthHandler {
	return &AuthHandler{svc: svc}
}

func (h *AuthHandler) Register(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Email       string `json:"email"`
		Password    string `json:"password"`
		DisplayName string `json:"display_name"`
	}
	if err := decodeJSON(r, &req); err != nil {
		writeError(w, http.StatusBadRequest, "format JSON tidak sah")
		return
	}

	token, user, err := h.svc.Register(r.Context(), req.Email, req.Password, req.DisplayName)
	if err != nil {
		switch {
		case errors.Is(err, service.ErrEmailTaken):
			writeError(w, http.StatusConflict, err.Error())
		case errors.Is(err, service.ErrInvalidEmail),
			errors.Is(err, service.ErrShortPassword),
			errors.Is(err, service.ErrDisplayNameRequired):
			writeError(w, http.StatusBadRequest, err.Error())
		default:
			log.Printf("register: unexpected error: %v", err)
			writeError(w, http.StatusInternalServerError, "ralat dalaman")
		}
		return
	}

	WriteJSON(w, http.StatusCreated, map[string]any{
		"token": token,
		"user":  user,
	})
}

func (h *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}
	if err := decodeJSON(r, &req); err != nil {
		writeError(w, http.StatusBadRequest, "format JSON tidak sah")
		return
	}

	token, user, err := h.svc.Login(r.Context(), req.Email, req.Password)
	if err != nil {
		switch {
		case errors.Is(err, service.ErrInvalidCredentials):
			writeError(w, http.StatusUnauthorized, err.Error())
		default:
			log.Printf("login: unexpected error: %v", err)
			writeError(w, http.StatusInternalServerError, "ralat dalaman")
		}
		return
	}

	WriteJSON(w, http.StatusOK, map[string]any{
		"token": token,
		"user":  user,
	})
}

func (h *AuthHandler) Me(w http.ResponseWriter, r *http.Request) {
	userID, ok := auth.UserIDFromContext(r.Context())
	if !ok {
		writeError(w, http.StatusInternalServerError, "auth middleware misconfigured")
		return
	}
	user, err := h.svc.GetUser(r.Context(), userID)
	if err != nil {
		writeError(w, http.StatusNotFound, "pengguna tidak dijumpai")
		return
	}
	WriteJSON(w, http.StatusOK, user)
}
