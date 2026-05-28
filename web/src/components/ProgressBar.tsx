interface Props {
  pct: number;
  label?: string;
}

export default function ProgressBar({ pct, label }: Props) {
  const clamped = Math.min(100, Math.max(0, pct));
  return (
    <div className="progress-bar-container" role="progressbar" aria-valuenow={clamped} aria-valuemin={0} aria-valuemax={100}>
      <div className="progress-bar-fill" style={{ width: `${clamped}%` }} />
      {label && <span className="progress-bar-label">{label}</span>}
    </div>
  );
}
