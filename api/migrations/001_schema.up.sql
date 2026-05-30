CREATE TABLE users (
    id            BIGSERIAL PRIMARY KEY,
    email         TEXT NOT NULL CHECK (email = LOWER(email)),
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
    topic_id    BIGINT NOT NULL REFERENCES topics(id) ON DELETE RESTRICT,
    name        TEXT NOT NULL,
    order_index INT NOT NULL
);

CREATE TABLE questions (
    id             BIGSERIAL PRIMARY KEY,
    subtopic_id    BIGINT NOT NULL REFERENCES subtopics(id) ON DELETE RESTRICT,
    type           TEXT NOT NULL CHECK (type IN ('mcq', 'short')),
    stem           TEXT NOT NULL,
    choices_json   JSONB,
    correct_answer TEXT NOT NULL,
    explanation    TEXT NOT NULL,
    difficulty     INT NOT NULL CHECK (difficulty BETWEEN 1 AND 5),
    CONSTRAINT short_answer_numeric CHECK (
        type != 'short' OR correct_answer ~ '^-?[0-9]+(\.[0-9]+)?$'
    ),
    CONSTRAINT mcq_has_choices CHECK (
        (type = 'mcq' AND choices_json IS NOT NULL) OR
        (type = 'short' AND choices_json IS NULL)
    )
);

CREATE TABLE attempts (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    question_id BIGINT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    is_correct  BOOLEAN NOT NULL,
    answered_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE reviews (
    id            BIGSERIAL PRIMARY KEY,
    user_id       BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    subtopic_id   BIGINT NOT NULL REFERENCES subtopics(id) ON DELETE CASCADE,
    ease          DOUBLE PRECISION NOT NULL DEFAULT 2.5,
    interval_days INT NOT NULL DEFAULT 1,
    due_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    reps          INT NOT NULL DEFAULT 0,
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (user_id, subtopic_id)
);

-- Case-insensitive email uniqueness; also used by login lookup on LOWER(email).
CREATE UNIQUE INDEX idx_users_email_lower ON users (LOWER(email));

-- Performance indexes
CREATE INDEX idx_reviews_user_due ON reviews(user_id, due_at);
CREATE INDEX idx_attempts_user_question ON attempts(user_id, question_id);
CREATE INDEX idx_questions_subtopic ON questions(subtopic_id);
