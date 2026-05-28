import { useQuery } from '@tanstack/react-query';
import { api } from '../api/client';
import SubtopicRow from '../components/SubtopicRow';
import t from '../i18n/ms';

export default function DashboardPage() {
  const { data, isLoading } = useQuery({
    queryKey: ['dashboard'],
    queryFn: api.dashboard,
  });

  if (isLoading || !data) return <div className="center-msg">{t.loading}</div>;

  return (
    <div className="dashboard-page">
      <div className="dashboard-summary">
        <div className="summary-card">
          <span className="summary-value">{data.due_count}</span>
          <span className="summary-label">{t.dueToday}</span>
        </div>
        <div className="summary-card">
          <span className="summary-value">{data.current_streak}</span>
          <span className="summary-label">{t.streak}</span>
        </div>
      </div>

      <h2>{t.mastery}</h2>
      <div className="subtopic-list">
        {data.subtopics.map((s) => (
          <SubtopicRow key={s.subtopic_id} item={s} />
        ))}
      </div>
    </div>
  );
}
