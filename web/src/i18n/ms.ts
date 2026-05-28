const ms = {
  appName: 'SPM Prep',
  tagline: 'Belajar Matematik SPM secara adaptif',

  // Auth
  login: 'Log Masuk',
  register: 'Daftar',
  logout: 'Log Keluar',
  email: 'Emel',
  password: 'Kata Laluan',
  displayName: 'Nama Paparan',
  noAccount: 'Belum ada akaun?',
  hasAccount: 'Sudah ada akaun?',
  registerHere: 'Daftar di sini',
  loginHere: 'Log masuk di sini',

  // Navigation
  practice: 'Latihan',
  dashboard: 'Papan Pemuka',

  // Practice
  nextQuestion: 'Soalan Seterusnya',
  submit: 'Hantar',
  correct: 'Betul!',
  incorrect: 'Salah',
  explanation: 'Penjelasan',
  yourAnswer: 'Jawapan anda',
  loading: 'Memuatkan...',
  noQuestions: 'Tiada soalan tersedia buat masa ini.',
  enterAnswer: 'Masukkan jawapan anda',

  // Dashboard
  mastery: 'Penguasaan',
  dueToday: 'Perlu ulangkaji hari ini',
  streak: 'Hari berturut-turut',
  subtopic: 'Subtopik',
  accuracy: 'Ketepatan',
  attempts: 'Percubaan',
  due: 'Perlu ulang',
  notStarted: 'Belum mula',
  days: 'hari',

  // Errors
  errorGeneric: 'Sesuatu telah berlaku. Sila cuba lagi.',
} as const;

export type I18nKey = keyof typeof ms;
export default ms;
