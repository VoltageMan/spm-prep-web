#!/usr/bin/env python3
"""
Validator for SPM Math question batches.

Usage:
    python validate_questions.py batches/batch_001_persamaan_linear.txt

Checks:
  1. Valid SQL INSERT syntax (basic parse)
  2. MCQ: exactly 4 choices A-D, correct_answer in {A,B,C,D}
  3. Short: choices_json is NULL, correct_answer is numeric
  4. Difficulty in {1,2,3,4,5}
  5. Explanation contains "Langkah" steps and "Jawapan:" line
  6. No duplicate stems within batch
  7. Cross-check: Jawapan in explanation matches chosen MCQ option
  8. Prints summary stats (type mix, difficulty distribution)
"""

import re
import sys
import json
from pathlib import Path


def parse_inserts(text: str) -> list[dict]:
    """Extract question records from SQL INSERT statements."""
    pattern = re.compile(
        r"VALUES\s*\n?\s*\("
        r"\s*(\d+)\s*,"            # subtopic_id
        r"\s*'(mcq|short)'\s*,"    # type
        r"\s*'((?:[^']|'')+)'\s*,"  # stem (escaped single quotes)
        r"\s*((?:'(?:[^']|'')*')|NULL)\s*,"  # choices_json or NULL
        r"\s*'((?:[^']|'')+)'\s*,"  # correct_answer
        r"\s*'((?:[^']|'')+)'\s*,"  # explanation
        r"\s*(\d+)"                # difficulty
        r"\s*\)",
        re.IGNORECASE | re.DOTALL,
    )

    questions = []
    for m in pattern.finditer(text):
        q = {
            "subtopic_id": int(m.group(1)),
            "type": m.group(2),
            "stem": m.group(3).replace("''", "'"),
            "choices_json_raw": m.group(4),
            "correct_answer": m.group(5).replace("''", "'"),
            "explanation": m.group(6).replace("''", "'"),
            "difficulty": int(m.group(7)),
        }
        if q["choices_json_raw"] == "NULL":
            q["choices"] = None
        else:
            raw = q["choices_json_raw"].strip("'").replace("''", "'")
            try:
                q["choices"] = json.loads(raw)
            except json.JSONDecodeError:
                q["choices"] = "PARSE_ERROR"
        questions.append(q)
    return questions


def validate(questions: list[dict]) -> list[str]:
    """Return list of error strings."""
    errors = []
    stems_seen: set[str] = set()

    for i, q in enumerate(questions, 1):
        prefix = f"Q{i} ('{q['stem'][:40]}...')"

        # Difficulty check
        if q["difficulty"] not in (1, 2, 3, 4, 5):
            errors.append(f"{prefix}: difficulty={q['difficulty']} not in 1-5")

        # Duplicate stem
        stem_norm = q["stem"].strip().lower()
        if stem_norm in stems_seen:
            errors.append(f"{prefix}: DUPLICATE stem")
        stems_seen.add(stem_norm)

        # Type-specific checks
        if q["type"] == "mcq":
            if q["choices"] == "PARSE_ERROR":
                errors.append(f"{prefix}: choices_json failed to parse as JSON")
            elif q["choices"] is None:
                errors.append(f"{prefix}: MCQ must have choices_json, got NULL")
            else:
                if len(q["choices"]) != 4:
                    errors.append(
                        f"{prefix}: MCQ must have 4 choices, got {len(q['choices'])}"
                    )
                expected_prefixes = ["A.", "B.", "C.", "D."]
                for j, choice in enumerate(q["choices"][:4]):
                    if not choice.strip().startswith(expected_prefixes[j]):
                        errors.append(
                            f"{prefix}: choice {j+1} should start with "
                            f"'{expected_prefixes[j]}', got '{choice[:5]}'"
                        )
            if q["correct_answer"] not in ("A", "B", "C", "D"):
                errors.append(
                    f"{prefix}: MCQ correct_answer='{q['correct_answer']}'"
                    " not in {A,B,C,D}"
                )

            # Cross-check: Jawapan in explanation must match the chosen option's value
            if (
                q["choices"]
                and q["choices"] != "PARSE_ERROR"
                and q["correct_answer"] in ("A", "B", "C", "D")
            ):
                jawapan_match = re.search(
                    r"Jawapan:\s*(.+?)(?:\n|$)", q["explanation"]
                )
                if jawapan_match:
                    jawapan_value = jawapan_match.group(1).strip()
                    letter_idx = ord(q["correct_answer"]) - ord("A")
                    if 0 <= letter_idx < len(q["choices"]):
                        chosen_choice = q["choices"][letter_idx]
                        chosen_value = re.sub(
                            r"^[A-D]\.\s*", "", chosen_choice
                        ).strip()
                        if jawapan_value != chosen_value:
                            errors.append(
                                f"{prefix}: Jawapan='{jawapan_value}' but option "
                                f"{q['correct_answer']}='{chosen_value}' — mismatch!"
                            )

        elif q["type"] == "short":
            if q["choices"] is not None:
                errors.append(f"{prefix}: short answer must have NULL choices")
            if not re.match(r"^-?\d+(\.\d+)?$", q["correct_answer"].strip()):
                errors.append(
                    f"{prefix}: short correct_answer='{q['correct_answer']}'"
                    " is not numeric"
                )

        # Explanation checks
        if "Langkah" not in q["explanation"]:
            errors.append(f"{prefix}: explanation missing 'Langkah' steps")
        if "Jawapan" not in q["explanation"]:
            errors.append(f"{prefix}: explanation missing 'Jawapan:' line")

    return errors


def print_stats(questions: list[dict]) -> None:
    """Print summary statistics."""
    total = len(questions)
    mcq = sum(1 for q in questions if q["type"] == "mcq")
    short = total - mcq
    diff_counts: dict[int, int] = {}
    for q in questions:
        diff_counts[q["difficulty"]] = diff_counts.get(q["difficulty"], 0) + 1

    print(f"\n{'='*50}")
    print(f"  Total questions: {total}")
    print(
        f"  MCQ: {mcq} ({mcq/total*100:.0f}%)  |  "
        f"Short: {short} ({short/total*100:.0f}%)"
    )
    print(f"  Difficulty distribution:")
    for d in sorted(diff_counts):
        count = diff_counts[d]
        print(f"    Level {d}: {count} ({count/total*100:.0f}%)")
    print(f"{'='*50}")


def main() -> None:
    if len(sys.argv) < 2:
        print("Usage: python validate_questions.py <batch_file>")
        sys.exit(1)

    filepath = Path(sys.argv[1])
    if not filepath.exists():
        print(f"ERROR: File not found: {filepath}")
        sys.exit(1)

    text = filepath.read_text(encoding="utf-8")
    questions = parse_inserts(text)

    if not questions:
        print(f"ERROR: No valid INSERT statements found in {filepath}")
        sys.exit(1)

    print(f"Parsed {len(questions)} questions from {filepath.name}")

    errors = validate(questions)

    if errors:
        print(f"\n{len(errors)} ERROR(S) FOUND:")
        for e in errors:
            print(f"  - {e}")
        print_stats(questions)
        sys.exit(1)
    else:
        print("\nAll checks passed!")
        print_stats(questions)
        sys.exit(0)


if __name__ == "__main__":
    main()