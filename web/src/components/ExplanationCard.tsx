import type { AnswerResponse } from '../api/client';
import { useI18n } from '../context/I18nContext';

interface Props {
  result: AnswerResponse;
  onNext: () => void;
}

export default function ExplanationCard({ result, onNext }: Props) {
  const { t } = useI18n();

  return (
    <div className={`explanation-card ${result.is_correct ? 'correct' : 'incorrect'}`}>
      <h3>{result.is_correct ? t.correct : t.incorrect}</h3>

      <div className="explanation-body">
        <h4>{t.explanation}</h4>
        {result.explanation.split(/\\n|\n/).map((line, i) => (
          <p key={i}>{line}</p>
        ))}
      </div>

      <button onClick={onNext} className="btn-primary" autoFocus>
        {t.nextQuestion}
      </button>
    </div>
  );
}
