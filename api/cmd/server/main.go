package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/go-chi/chi/v5"
	chimw "github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/spm-prep/api/internal/auth"
	"github.com/spm-prep/api/internal/config"
	"github.com/spm-prep/api/internal/handler"
	"github.com/spm-prep/api/internal/repository"
	"github.com/spm-prep/api/internal/service"
)

func main() {
	cfg, err := config.Load()
	if err != nil {
		log.Fatalf("config: %v", err)
	}

	ctx := context.Background()
	pool, err := pgxpool.New(ctx, cfg.DatabaseURL)
	if err != nil {
		log.Fatalf("db: %v", err)
	}
	defer pool.Close()

	if err := pool.Ping(ctx); err != nil {
		log.Fatalf("db ping: %v", err)
	}
	log.Println("connected to database")

	// Repositories
	userRepo := repository.NewUserRepo(pool)
	questionRepo := repository.NewQuestionRepo(pool)
	attemptRepo := repository.NewAttemptRepo(pool)
	reviewRepo := repository.NewReviewRepo(pool)
	reportRepo := repository.NewReportRepo(pool)

	// Services
	authSvc := service.NewAuthService(userRepo, cfg.JWTSecret)
	practiceSvc := service.NewPracticeService(questionRepo, attemptRepo, reviewRepo)
	reportSvc := service.NewReportService(reportRepo)

	// Handlers
	authH := handler.NewAuthHandler(authSvc)
	practiceH := handler.NewPracticeHandler(practiceSvc)
	dashH := handler.NewDashboardHandler(practiceSvc)
	reportH := handler.NewReportHandler(reportSvc)

	// Router
	r := chi.NewRouter()
	r.Use(chimw.Logger)
	r.Use(chimw.Recoverer)
	r.Use(cors.Handler(cors.Options{
		AllowedOrigins:   cfg.AllowedOrigins,
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type"},
		AllowCredentials: true,
		MaxAge:           300,
	}))

	// Health check
	r.Get("/api/health", func(w http.ResponseWriter, r *http.Request) {
		handler.WriteJSON(w, http.StatusOK, map[string]string{"status": "ok"})
	})

	// Public routes
	r.Post("/api/auth/register", authH.Register)
	r.Post("/api/auth/login", authH.Login)

	// Protected routes
	r.Group(func(r chi.Router) {
		r.Use(auth.Middleware(cfg.JWTSecret))
		r.Get("/api/auth/me", authH.Me)
		r.Get("/api/practice/next", practiceH.NextQuestion)
		r.Post("/api/practice/answer", practiceH.SubmitAnswer)
		r.Get("/api/dashboard", dashH.Dashboard)
		r.Get("/api/topics", dashH.Topics)
		r.Post("/api/questions/{id}/report", reportH.Report)
	})

	srv := &http.Server{
		Addr:              ":" + cfg.Port,
		Handler:           r,
		ReadHeaderTimeout: 5 * time.Second,
		ReadTimeout:       15 * time.Second,
		WriteTimeout:      30 * time.Second,
		IdleTimeout:       60 * time.Second,
	}

	// Graceful shutdown
	go func() {
		sigCh := make(chan os.Signal, 1)
		signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
		<-sigCh
		log.Println("shutting down...")
		shutdownCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()
		if err := srv.Shutdown(shutdownCtx); err != nil {
			log.Printf("shutdown error: %v", err)
		}
	}()

	log.Printf("server starting on :%s", cfg.Port)
	if err := srv.ListenAndServe(); err != http.ErrServerClosed {
		log.Fatalf("server: %v", err)
	}
}
