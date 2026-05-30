const API_BASE = import.meta.env.VITE_API_URL || '';

// sessionStorage chosen over localStorage so token dies when the tab closes;
// future iteration should move to httpOnly cookie + CSRF token.
let token: string | null = sessionStorage.getItem('jwt');

export function setToken(t: string | null) {
  token = t;
  if (t) {
    sessionStorage.setItem('jwt', t);
  } else {
    sessionStorage.removeItem('jwt');
  }
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
    const err = new ApiError(body.error || `HTTP ${res.status}`, res.status);
    throw err;
  }
  return res.json();
}

export class ApiError extends Error {
  status: number;
  constructor(message: string, status: number) {
    super(message);
    this.status = status;
  }
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

  reportQuestion: async (questionId: number, reason: string): Promise<void> => {
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
    };
    if (token) {
      headers['Authorization'] = `Bearer ${token}`;
    }

    const res = await fetch(`${API_BASE}/api/questions/${questionId}/report`, {
      method: 'POST',
      headers,
      body: JSON.stringify({ reason }),
    });

    if (!res.ok) {
      const body = await res.json().catch(() => ({ error: 'Ralat rangkaian' }));
      throw new ApiError(body.error || `HTTP ${res.status}`, res.status);
    }
  },
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
