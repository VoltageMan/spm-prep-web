import { createContext, useContext, useState, type ReactNode } from 'react';
import { locales, localeLabels, type Locale, type I18nKey } from '../i18n';

interface I18nState {
  locale: Locale;
  setLocale: (l: Locale) => void;
  t: Record<I18nKey, string>;
  localeLabels: typeof localeLabels;
}

const I18nContext = createContext<I18nState | null>(null);

function getSavedLocale(): Locale {
  try {
    const saved = localStorage.getItem('locale') as Locale | null;
    if (saved && saved in locales) return saved;
  } catch {}
  return 'en';
}

export function I18nProvider({ children }: { children: ReactNode }) {
  const [locale, setLocaleState] = useState<Locale>(getSavedLocale);

  const setLocale = (l: Locale) => {
    localStorage.setItem('locale', l);
    setLocaleState(l);
  };

  return (
    <I18nContext.Provider value={{ locale, setLocale, t: locales[locale] as Record<I18nKey, string>, localeLabels }}>
      {children}
    </I18nContext.Provider>
  );
}

export function useI18n() {
  const ctx = useContext(I18nContext);
  if (!ctx) throw new Error('useI18n must be used within I18nProvider');
  return ctx;
}
