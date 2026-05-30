import { useState, useCallback } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import { api, type AnswerResponse } from '../api/client';
import QuestionCard from '../components/QuestionCard';
import ExplanationCard from '../components/ExplanationCard';
import { useI18n } from '../context/I18nContext';

export default function PracticePage() {
  const { t } = useI18n();
  const queryClient = useQueryClient();
  const [result, setResult] = useState<AnswerResponse | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const { data: question, isLoading, error } = useQuery({
    queryKey: ['nextQuestion'],
    queryFn: api.nextQuestion,
    retry: false,
  });

  const handleSubmit = useCallback(async (answer: string) => {
    if (!question) return;
    setSubmitting(true);
    try {
      const res = await api.submitAnswer(question.id, answer);
      setResult(res);
    } catch {
      // Handled by error state
    } finally {
      setSubmitting(false);
    }
  }, [question]);

  const handleNext = useCallback(() => {
    setResult(null);
    queryClient.invalidateQueries({ queryKey: ['nextQuestion'] });
  }, [queryClient]);

  if (isLoading) return <div className="center-msg">{t.loading}</div>;
  if (error || !question) return <div className="center-msg">{t.noQuestions}</div>;

  return (
    <div className="practice-page">
      {result ? (
        <ExplanationCard result={result} questionId={question.id} onNext={handleNext} />
      ) : (
        <QuestionCard question={question} onSubmit={handleSubmit} disabled={submitting} />
      )}
    </div>
  );
}
