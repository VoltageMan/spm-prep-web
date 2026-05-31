# SPM Mathematics Question Generator — Prompt Template

## Instructions for AI

You are an expert SPM Mathematics question writer. Generate questions for the **{{SUBTOPIC_NAME}}** subtopic (subtopic_id = {{SUBTOPIC_ID}}).

### Requirements

1. **Language**: All content MUST be in Bahasa Melayu (BM).
2. **Question types**: Mix of `mcq` (multiple choice) and `short` (short numeric answer). Aim for ~60% mcq, ~40% short.
3. **Difficulty distribution**: Generate questions across difficulties 1 (mudah), 2 (sederhana), 3 (sukar). Aim for roughly 30% / 40% / 30%.
4. **MCQ format**:
   - Exactly 4 choices labeled A, B, C, D.
   - Choices as JSON array: `["A. ...", "B. ...", "C. ...", "D. ..."]`
   - Distractors must be plausible (common mistakes, not random numbers).
   - `correct_answer` is a single letter: `A`, `B`, `C`, or `D`.
5. **Short answer format**:
   - `choices_json` must be `NULL`.
   - `correct_answer` must be a plain number (integer or decimal), e.g. `12`, `-3`, `0.75`.
   - No units, no text — just the number.
6. **Explanation format**:
   - Step-by-step in BM using "Langkah 1:", "Langkah 2:", etc.
   - End with "Jawapan: ..." line.
   - Keep explanations concise but complete — a Form 4/5 student should follow every step.
7. **Stem (question text)**:
   - Must be self-contained — no references to diagrams or external material.
   - Use real-world context where possible (harga, jarak, pelajar, etc.).
   - Avoid identical phrasing to existing questions (see examples below).

### Output format

Output each question as a SQL INSERT statement, ready to paste into a migration file:

```sql
INSERT INTO questions (subtopic_id, type, stem, choices_json, correct_answer, explanation, difficulty) VALUES
({{SUBTOPIC_ID}}, '{{type}}',
 '{{stem}}',
 {{choices_json_or_NULL}},
 '{{correct_answer}}',
 '{{explanation}}',
 {{difficulty}});
```

Generate exactly **{{NUM_QUESTIONS}}** questions.

---

### Few-shot examples (from existing database)

{{EXAMPLES}}
