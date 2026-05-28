CREATE TABLE users (
    id            BIGSERIAL PRIMARY KEY,
    email         TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    display_name  TEXT NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE topics (
    id          BIGSERIAL PRIMARY KEY,
    subject     TEXT NOT NULL,
    name        TEXT NOT NULL,
    order_index INT NOT NULL
);

CREATE TABLE subtopics (
    id          BIGSERIAL PRIMARY KEY,
    topic_id    BIGINT NOT NULL REFERENCES topics(id),
    name        TEXT NOT NULL,
    order_index INT NOT NULL
);

CREATE TABLE questions (
    id             BIGSERIAL PRIMARY KEY,
    subtopic_id    BIGINT NOT NULL REFERENCES subtopics(id),
    type           TEXT NOT NULL CHECK (type IN ('mcq', 'short')),
    stem           TEXT NOT NULL,
    choices_json   JSONB,
    correct_answer TEXT NOT NULL,
    explanation    TEXT NOT NULL,
    difficulty     INT NOT NULL CHECK (difficulty BETWEEN 1 AND 5)
);

CREATE TABLE attempts (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT NOT NULL REFERENCES users(id),
    question_id BIGINT NOT NULL REFERENCES questions(id),
    is_correct  BOOLEAN NOT NULL,
    answered_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE reviews (
    id            BIGSERIAL PRIMARY KEY,
    user_id       BIGINT NOT NULL REFERENCES users(id),
    subtopic_id   BIGINT NOT NULL REFERENCES subtopics(id),
    ease          DOUBLE PRECISION NOT NULL DEFAULT 2.5,
    interval_days INT NOT NULL DEFAULT 1,
    due_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    reps          INT NOT NULL DEFAULT 0,
    UNIQUE (user_id, subtopic_id)
);

-- Performance indexes
CREATE INDEX idx_reviews_user_due ON reviews(user_id, due_at);
CREATE INDEX idx_attempts_user_question ON attempts(user_id, question_id);
CREATE INDEX idx_questions_subtopic ON questions(subtopic_id);
