import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import t from '../i18n/ms';

export default function Navbar() {
  const { user, logout } = useAuth();

  if (!user) return null;

  return (
    <nav className="navbar">
      <Link to="/practice" className="nav-brand">{t.appName}</Link>
      <div className="nav-links">
        <Link to="/practice">{t.practice}</Link>
        <Link to="/dashboard">{t.dashboard}</Link>
        <span className="nav-user">{user.display_name}</span>
        <button onClick={logout} className="btn-link">{t.logout}</button>
      </div>
    </nav>
  );
}
