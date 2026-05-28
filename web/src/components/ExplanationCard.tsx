import type { AnswerResponse } from '../api/client';
import t from '../i18n/ms';

interface Props {
  result: AnswerResponse;
  onNext: () => void;
}

export default function ExplanationCard({ result, onNext }: Props) {
  return (
    <div className={`explanation-card ${result.is_correct ? 'correct' : 'incorrect'}`}>
      <h3>{result.is_correct ? t.correct : t.incorrect}</h3>

      <div className="explanation-body">
        <h4>{t.explanation}</h4>
        {result.explanation.split('\n').map((line, i) => (
          <p key={i}>{line}</p>
        ))}
      </div>

      <button onClick={onNext} className="btn-primary" autoFocus>
        {t.nextQuestion}
      </button>
    </div>
  );
}
