import '@mdi/font/css/materialdesignicons.css';
import { createVuetify } from 'vuetify';

const baseTemplateTheme = {
  dark: false,
  colors: {
    background: '#FFFFFF',
    surface: '#FFFFFF',
    primary: '#058ED9',
    secondary: '#D14081',
    error: '#FE6D73',
    info: '#9DD1F1',
    success: '#70A37F',
    warning: '#F3C969',
  },
};

export default defineNuxtPlugin((app) => {
  const vuetify = createVuetify({
    theme: {
      defaultTheme: 'baseTemplateTheme',
      themes: {
        baseTemplateTheme,
      },
    },
  });
  app.vueApp.use(vuetify);
});
