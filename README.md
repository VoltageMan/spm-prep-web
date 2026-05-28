# SPM Prep — Adaptive Math Exam Prep

Free, adaptive SPM Mathematics exam preparation platform for Malaysian students. Uses spaced repetition (SM-2) and accuracy-based prioritization to focus study on weak areas.

## Quick Start (Docker)

```bash
cp .env.example .env
# Edit .env to set a real JWT_SECRET for production

docker compose up --build
```

- **Frontend**: http://localhost:3000
- **API**: http://localhost:8080
- **DB**: localhost:5432 (user: spmprep)

Migrations and seed data run automatically on first start.

## Local Development (without Docker)

### Prerequisites
- Go 1.25+
- Node.js 22+
- PostgreSQL 16+

### Database

```bash
createdb spmprep
psql spmprep < api/migrations/001_schema.up.sql
psql spmprep < api/migrations/002_seed.up.sql
```

### Backend

```bash
cd api
export DATABASE_URL="postgres://localhost:5432/spmprep?sslmode=disable"
export JWT_SECRET="dev-secret"
go run ./cmd/server
```

### Frontend

```bash
cd web
npm install
npm run dev
```

Frontend runs at http://localhost:5173 and proxies `/api` to the Go server.

## Running Tests

```bash
cd api
go test ./internal/service/ -v
```

Tests cover:
- SM-2 spaced repetition algorithm (7 cases)
- Subtopic selection algorithm (7 cases)
- Answer checking — MCQ and numeric (12 cases)

## API Endpoints

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| POST | /api/auth/register | No | Create account |
| POST | /api/auth/login | No | Log in |
| GET | /api/auth/me | Yes | Current user |
| GET | /api/practice/next | Yes | Next adaptive question |
| POST | /api/practice/answer | Yes | Submit answer |
| GET | /api/dashboard | Yes | Progress stats |
| GET | /api/topics | Yes | All topics & subtopics |

## Architecture

```
Browser → nginx (SPA + /api proxy) → Go API (chi) → PostgreSQL

Go layers: handler → service → repository
Algorithm: pure functions in service/ with table-driven tests
```

## Seed Data

3 topics, 8 subtopics, 40 questions covering:
- Nombor dan Operasi (integers, fractions, percentages)
- Algebra (expressions, linear equations, inequalities)
- Geometri dan Ukuran (perimeter/area, volume/surface area)
# spm-prep-web
