import type { SubtopicProgress } from '../api/client';
import ProgressBar from './ProgressBar';
import t from '../i18n/ms';

interface Props {
  item: SubtopicProgress;
}

export default function SubtopicRow({ item }: Props) {
  return (
    <div className="subtopic-row">
      <div className="subtopic-info">
        <span className="subtopic-name">{item.subtopic_name}</span>
        <span className="subtopic-topic">{item.topic_name}</span>
      </div>
      <div className="subtopic-stats">
        {item.total_attempts > 0 ? (
          <>
            <ProgressBar pct={item.mastery_pct} label={`${Math.round(item.mastery_pct)}%`} />
            <span className="stat-detail">
              {item.correct_count}/{item.total_attempts} {t.attempts}
            </span>
          </>
        ) : (
          <span className="stat-not-started">{t.notStarted}</span>
        )}
        {item.is_due_today && <span className="badge-due">{t.due}</span>}
      </div>
    </div>
  );
}
