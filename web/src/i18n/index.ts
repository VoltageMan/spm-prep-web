import en from './en';
import zh from './zh';
import hi from './hi';
import ms from './ms';

export type Locale = 'en' | 'zh' | 'hi' | 'ms';
export type I18nKey = keyof typeof en;

export const locales: Record<Locale, Record<I18nKey, string>> = { en, zh, hi, ms };

export const localeLabels: Record<Locale, string> = {
  en: 'English',
  zh: '中文',
  hi: 'हिन्दी',
  ms: 'Melayu',
};
