package service

import (
	"context"
	"errors"
	"net/mail"
	"strings"
	"unicode/utf8"

	"github.com/spm-prep/api/internal/auth"
	"github.com/spm-prep/api/internal/model"
	"github.com/spm-prep/api/internal/repository"
)

type AuthService struct {
	users      *repository.UserRepo
	jwtSecret  string
	dummyHash  string
}

func NewAuthService(users *repository.UserRepo, jwtSecret string) *AuthService {
	dummy, _ := auth.HashPassword("dummy-constant-value-for-timing-equalization")
	return &AuthService{users: users, jwtSecret: jwtSecret, dummyHash: dummy}
}

func (s *AuthService) Register(ctx context.Context, email, password, displayName string) (string, *model.User, error) {
	email = strings.ToLower(strings.TrimSpace(email))
	if _, err := mail.ParseAddress(email); err != nil {
		return "", nil, errors.New("alamat emel tidak sah")
	}
	if utf8.RuneCountInString(password) < 8 {
		return "", nil, errors.New("kata laluan mesti sekurang-kurangnya 8 aksara")
	}
	if displayName == "" {
		return "", nil, errors.New("nama paparan diperlukan")
	}

	hash, err := auth.HashPassword(password)
	if err != nil {
		return "", nil, err
	}

	user, err := s.users.Create(ctx, email, hash, displayName)
	if err != nil {
		return "", nil, errors.New("emel sudah didaftarkan")
	}

	token, err := auth.GenerateToken(user.ID, s.jwtSecret)
	if err != nil {
		return "", nil, err
	}
	return token, user, nil
}

func (s *AuthService) Login(ctx context.Context, email, password string) (string, *model.User, error) {
	email = strings.ToLower(strings.TrimSpace(email))
	user, err := s.users.GetByEmail(ctx, email)
	if err != nil {
		auth.CheckPassword(s.dummyHash, password)
		return "", nil, errors.New("emel atau kata laluan salah")
	}
	if !auth.CheckPassword(user.PasswordHash, password) {
		return "", nil, errors.New("emel atau kata laluan salah")
	}

	token, err := auth.GenerateToken(user.ID, s.jwtSecret)
	if err != nil {
		return "", nil, err
	}
	return token, user, nil
}

func (s *AuthService) GetUser(ctx context.Context, id int64) (*model.User, error) {
	return s.users.GetByID(ctx, id)
}
