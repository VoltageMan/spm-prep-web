import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useI18n } from '../context/I18nContext';
import { type Locale } from '../i18n';

export default function Navbar() {
  const { user, logout } = useAuth();
  const { t, locale, setLocale, localeLabels } = useI18n();

  return (
    <nav className="navbar">
      <Link to="/practice" className="nav-brand">{t.appName}</Link>
      <div className="nav-links">
        {user && (
          <>
            <Link to="/practice">{t.practice}</Link>
            <Link to="/dashboard">{t.dashboard}</Link>
            <span className="nav-user">{user.display_name}</span>
            <button onClick={logout} className="btn-link">{t.logout}</button>
            <select
              className="lang-select"
              value={locale}
              onChange={(e) => setLocale(e.target.value as Locale)}
              aria-label="Language"
            >
              {(Object.entries(localeLabels) as [Locale, string][]).map(([code, label]) => (
                <option key={code} value={code}>{label}</option>
              ))}
            </select>
          </>
        )}
      </div>
    </nav>
  );
}
