import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useI18n } from '../context/I18nContext';
import { type Locale } from '../i18n';

export default function LoginPage() {
  const { login, isLoading } = useAuth();
  const { t, locale, setLocale, localeLabels } = useI18n();
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    try {
      await login(email, password);
      navigate('/practice');
    } catch (err: any) {
      setError(err.message);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-card">
        <div className="auth-lang-row">
          <select
            className="lang-select-light"
            value={locale}
            onChange={(e) => setLocale(e.target.value as Locale)}
            aria-label="Language"
          >
            {(Object.entries(localeLabels) as [Locale, string][]).map(([code, label]) => (
              <option key={code} value={code}>{label}</option>
            ))}
          </select>
        </div>
        <h1>{t.appName}</h1>
        <p className="tagline">{t.tagline}</p>

        <form onSubmit={handleSubmit}>
          <label>
            {t.email}
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              autoComplete="email"
            />
          </label>
          <label>
            {t.password}
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              autoComplete="current-password"
            />
          </label>
          {error && <p className="error">{error}</p>}
          <button type="submit" className="btn-primary" disabled={isLoading}>
            {t.login}
          </button>
        </form>

        <p className="auth-switch">
          {t.noAccount} <Link to="/register">{t.registerHere}</Link>
        </p>
      </div>
    </div>
  );
}
