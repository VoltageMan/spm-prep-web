package service

import "errors"

var (
	ErrInvalidEmail         = errors.New("alamat emel tidak sah")
	ErrShortPassword        = errors.New("kata laluan mesti sekurang-kurangnya 8 aksara")
	ErrDisplayNameRequired  = errors.New("nama paparan diperlukan")
	ErrEmailTaken           = errors.New("emel sudah didaftarkan")
	ErrInvalidCredentials   = errors.New("emel atau kata laluan salah")
	ErrQuestionNotFound     = errors.New("soalan tidak dijumpai")
	ErrNoQuestionsAvailable = errors.New("tiada soalan tersedia")
	ErrReasonTooLong        = errors.New("alasan terlalu panjang")
	ErrAlreadyReported      = errors.New("anda sudah melaporkan soalan ini")
)
