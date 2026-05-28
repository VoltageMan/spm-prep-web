import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import t from '../i18n/ms';

export default function RegisterPage() {
  const { register, isLoading } = useAuth();
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [displayName, setDisplayName] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    try {
      await register(email, password, displayName);
      navigate('/practice');
    } catch (err: any) {
      setError(err.message);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-card">
        <h1>{t.appName}</h1>
        <p className="tagline">{t.tagline}</p>

        <form onSubmit={handleSubmit}>
          <label>
            {t.displayName}
            <input
              type="text"
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              required
            />
          </label>
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
              minLength={8}
              autoComplete="new-password"
            />
          </label>
          {error && <p className="error">{error}</p>}
          <button type="submit" className="btn-primary" disabled={isLoading}>
            {t.register}
          </button>
        </form>

        <p className="auth-switch">
          {t.hasAccount} <Link to="/login">{t.loginHere}</Link>
        </p>
      </div>
    </div>
  );
}
