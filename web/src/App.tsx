import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { AuthProvider, useAuth } from './context/AuthContext';
import Navbar from './components/Navbar';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import PracticePage from './pages/PracticePage';
import DashboardPage from './pages/DashboardPage';
import './styles/global.css';

const queryClient = new QueryClient({
  defaultOptions: { queries: { staleTime: 30_000, refetchOnWindowFocus: false } },
});

function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { user } = useAuth();
  if (!user) return <Navigate to="/login" replace />;
  return <>{children}</>;
}

function AppRoutes() {
  const { user } = useAuth();
  return (
    <>
      <Navbar />
      <main className="main-content">
        <Routes>
          <Route path="/login" element={user ? <Navigate to="/practice" replace /> : <LoginPage />} />
          <Route path="/register" element={user ? <Navigate to="/practice" replace /> : <RegisterPage />} />
          <Route path="/practice" element={<ProtectedRoute><PracticePage /></ProtectedRoute>} />
          <Route path="/dashboard" element={<ProtectedRoute><DashboardPage /></ProtectedRoute>} />
          <Route path="*" element={<Navigate to={user ? '/practice' : '/login'} replace />} />
        </Routes>
      </main>
    </>
  );
}

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <AuthProvider>
        <BrowserRouter>
          <AppRoutes />
        </BrowserRouter>
      </AuthProvider>
    </QueryClientProvider>
  );
}
