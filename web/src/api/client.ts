const API_BASE = import.meta.env.VITE_API_URL || '';

// JWT is stored in memory (not localStorage) to reduce XSS attack surface.
// Trade-off: token is lost on page refresh, requiring re-login.
// For MVP this is acceptable; a future version could use httpOnly cookies
// or localStorage with a clear comment about the XSS risk.
let token: string | null = null;

export function setToken(t: string | null) {
  token = t;
}

export function getToken(): string | null {
  return token;
}

async function request<T>(path: string, opts: RequestInit = {}): Promise<T> {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    ...(opts.headers as Record<string, string>),
  };
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const res = await fetch(`${API_BASE}${path}`, { ...opts, headers });

  if (!res.ok) {
    const body = await res.json().catch(() => ({ error: 'Ralat rangkaian' }));
    throw new Error(body.error || `HTTP ${res.status}`);
  }
  return res.json();
}

export const api = {
  register: (email: string, password: string, display_name: string) =>
    request<{ token: string; user: User }>('/api/auth/register', {
      method: 'POST',
      body: JSON.stringify({ email, password, display_name }),
    }),

  login: (email: string, password: string) =>
    request<{ token: string; user: User }>('/api/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    }),

  me: () => request<User>('/api/auth/me'),

  nextQuestion: () => request<Question>('/api/practice/next'),

  submitAnswer: (question_id: number, answer: string) =>
    request<AnswerResponse>('/api/practice/answer', {
      method: 'POST',
      body: JSON.stringify({ question_id, answer }),
    }),

  dashboard: () => request<DashboardData>('/api/dashboard'),

  topics: () => request<TopicWithSubtopics[]>('/api/topics'),
};

// Types
export interface User {
  id: number;
  email: string;
  display_name: string;
  created_at: string;
}

export interface Question {
  id: number;
  subtopic_id: number;
  type: 'mcq' | 'short';
  stem: string;
  choices?: string[];
  difficulty: number;
}

export interface AnswerResponse {
  is_correct: boolean;
  explanation: string;
  updated_review: {
    ease: number;
    interval_days: number;
    due_at: string;
    reps: number;
  };
}

export interface SubtopicProgress {
  subtopic_id: number;
  subtopic_name: string;
  topic_name: string;
  total_attempts: number;
  correct_count: number;
  mastery_pct: number;
  is_due_today: boolean;
}

export interface DashboardData {
  subtopics: SubtopicProgress[];
  due_count: number;
  current_streak: number;
}

export interface Subtopic {
  id: number;
  topic_id: number;
  name: string;
  order_index: number;
}

export interface TopicWithSubtopics {
  id: number;
  subject: string;
  name: string;
  order_index: number;
  subtopics: Subtopic[];
}
