import { useState } from 'react';
import type { Question } from '../api/client';
import { useI18n } from '../context/I18nContext';

interface Props {
  question: Question;
  onSubmit: (answer: string) => void;
  disabled: boolean;
}

export default function QuestionCard({ question, onSubmit, disabled }: Props) {
  const { t } = useI18n();
  const [selected, setSelected] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selected.trim()) {
      onSubmit(selected.trim());
    }
  };

  return (
    <form onSubmit={handleSubmit} className="question-card">
      <p className="question-stem">{question.stem}</p>

      {question.type === 'mcq' && question.choices ? (
        <div className="choices" role="radiogroup">
          {question.choices.map((choice, i) => (
            <label key={i} className={`choice ${selected === choice.charAt(0) ? 'selected' : ''}`}>
              <input
                type="radio"
                name="answer"
                value={choice.charAt(0)}
                checked={selected === choice.charAt(0)}
                onChange={(e) => setSelected(e.target.value)}
                disabled={disabled}
              />
              {choice}
            </label>
          ))}
        </div>
      ) : (
        <input
          type="text"
          inputMode="decimal"
          className="short-input"
          placeholder={t.enterAnswer}
          value={selected}
          onChange={(e) => setSelected(e.target.value)}
          disabled={disabled}
          autoFocus
        />
      )}

      <button type="submit" className="btn-primary" disabled={disabled || !selected.trim()}>
        {t.submit}
      </button>
    </form>
  );
}
