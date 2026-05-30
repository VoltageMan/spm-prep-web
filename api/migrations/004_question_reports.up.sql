CREATE TABLE question_reports (
    id          BIGSERIAL PRIMARY KEY,
    question_id BIGINT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    user_id     BIGINT REFERENCES users(id) ON DELETE SET NULL,
    reason      TEXT CHECK (reason IS NULL OR char_length(reason) <= 500),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    resolved_at TIMESTAMPTZ
);

CREATE INDEX idx_reports_unresolved ON question_reports(resolved_at)
    WHERE resolved_at IS NULL;
