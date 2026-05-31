import { useState, useEffect } from 'react';
import { api, ApiError, type AnswerResponse } from '../api/client';
import { useI18n } from '../context/I18nContext';

type ReportState = 'collapsed' | 'expanded' | 'submitting' | 'thanks' | 'duplicate' | 'error';

interface Props {
  result: AnswerResponse;
  questionId: number;
  onNext: () => void;
}

export default function ExplanationCard({ result, questionId, onNext }: Props) {
  const { t } = useI18n();
  const [reportState, setReportState] = useState<ReportState>('collapsed');
  const [reason, setReason] = useState('');

  useEffect(() => {
    if (reportState !== 'thanks') return;
    const timer = setTimeout(() => setReportState('collapsed'), 3000);
    return () => clearTimeout(timer);
  }, [reportState]);

  const handleSubmit = async () => {
    setReportState('submitting');
    try {
      await api.reportQuestion(questionId, reason);
      setReason('');
      setReportState('thanks');
    } catch (err) {
      if (err instanceof ApiError && err.status === 409) {
        setReportState('duplicate');
      } else {
        setReportState('error');
      }
    }
  };

  // The DB stores line breaks as literal text ("\n" and sometimes "\\n"),
  // not as real newline characters. Convert both forms to real newlines
  // before splitting, so each step renders on its own line.
  const explanationLines = result.explanation
    .replace(/\\\\n/g, '\n') // literal "\\n" (two backslashes + n) -> newline
    .replace(/\\n/g, '\n')   // literal "\n"  (one backslash  + n) -> newline
    .split('\n');

  return (
    <div className={`explanation-card ${result.is_correct ? 'correct' : 'incorrect'}`}>
      <h3>{result.is_correct ? t.correct : t.incorrect}</h3>

      <div className="explanation-body">
        <h4>{t.explanation}</h4>
        {explanationLines.map((line, i) => (
          <p key={i}>{line}</p>
        ))}
      </div>

      <div className="report-section">
        {reportState === 'collapsed' && (
          <button
            className="report-link"
            onClick={() => setReportState('expanded')}
          >
            {t.reportButton}
          </button>
        )}

        {(reportState === 'expanded' || reportState === 'submitting') && (
          <div className="report-panel">
            <textarea
              className="report-textarea"
              placeholder={t.reportPlaceholder}
              value={reason}
              onChange={(e) => setReason(e.target.value)}
              maxLength={500}
              disabled={reportState === 'submitting'}
              autoFocus
            />
            <div className={`report-counter${reason.length > 500 ? ' report-counter-over' : ''}`}>
              {reason.length}/500
            </div>
            <div className="report-actions">
              <button
                className="report-btn-cancel"
                onClick={() => { setReportState('collapsed'); setReason(''); }}
                disabled={reportState === 'submitting'}
              >
                {t.reportCancel}
              </button>
              <button
                className="report-btn-submit"
                onClick={handleSubmit}
                disabled={reportState === 'submitting'}
              >
                {reportState === 'submitting' ? t.reportSubmitting : t.reportSubmit}
              </button>
            </div>
          </div>
        )}

        {reportState === 'thanks' && (
          <p className="report-thanks">{t.reportThanks}</p>
        )}

        {reportState === 'duplicate' && (
          <p className="report-duplicate">{t.reportDuplicate}</p>
        )}

        {reportState === 'error' && (
          <div className="report-panel">
            <p className="report-error">{t.reportError}</p>
            <textarea
              className="report-textarea"
              placeholder={t.reportPlaceholder}
              value={reason}
              onChange={(e) => setReason(e.target.value)}
              maxLength={500}
              autoFocus
            />
            <div className={`report-counter${reason.length > 500 ? ' report-counter-over' : ''}`}>
              {reason.length}/500
            </div>
            <div className="report-actions">
              <button
                className="report-btn-cancel"
                onClick={() => { setReportState('collapsed'); setReason(''); }}
              >
                {t.reportCancel}
              </button>
              <button
                className="report-btn-submit"
                onClick={handleSubmit}
              >
                {t.reportSubmit}
              </button>
            </div>
          </div>
        )}
      </div>

      <button onClick={onNext} className="btn-primary" autoFocus>
        {t.nextQuestion}
      </button>
    </div>
  );
}