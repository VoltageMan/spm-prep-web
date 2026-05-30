-- NOTE: extra questions added to existing subtopics 1-8 cannot
-- be cleanly identified for rollback. For a full reset to the
-- state after migration 002, rebuild the database.

-- Delete questions first (questions.subtopic_id is ON DELETE RESTRICT).
DELETE FROM questions WHERE subtopic_id IN (9, 10, 11, 12, 13, 14);

-- Subtopics cascade to reviews (reviews.subtopic_id ON DELETE CASCADE).
DELETE FROM subtopics WHERE id IN (9, 10, 11, 12, 13, 14);

-- Topics can now be removed (no more subtopics referencing them).
DELETE FROM topics WHERE id IN (4, 5, 6, 7);
