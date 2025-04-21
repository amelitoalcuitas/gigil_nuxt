import en from './localization/en';
import ja from './localization/ja';

export default defineI18nConfig(() => ({
  legacy: false,
  locale: 'en',
  messages: {
    en,
    ja,
  },
}));
