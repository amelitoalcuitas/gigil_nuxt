import vuetify, { transformAssetUrls } from 'vite-plugin-vuetify';

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  ssr: false,
  build: {
    transpile: ['vuetify'],
    extractCSS: true,
    optimization: {
      minimize: true,
    },
    hotMiddleware: {
      client: {
        overlay: true,
      },
    },
  },
  // disable sourcemap so the terminal warnings go away
  sourcemap: {
    client: false,
    server: false,
  },
  experimental: {
    inlineSSRStyles: false, // for production build
  },
  css: ['vuetify/styles'],
  modules: [
    (_options, nuxt) => {
      nuxt.hooks.hook('vite:extendConfig', (config) => {
        // @ts-expect-error
        config.plugins.push(
          vuetify({
            styles: { configFile: 'styles/settings.scss' },
          })
        );
      });
    },
    '@nuxtjs/i18n',
    '@pinia/nuxt',
  ],
  vite: {
    vue: {
      template: {
        transformAssetUrls,
      },
    },
	server: {
      hmr: true,
      watch: {
        usePolling: true,
      },
    },
  },
  runtimeConfig: {
    public: {
      appName: process.env.NUXT_ENV_SITE_TITLE,
      clientId: process.env.NUXT_ENV_CLIENT_ID,
      clientSecret: process.env.NUXT_ENV_CLIENT_SECRET,
      siteUrl: process.env.NUXT_ENV_SITE_URL,
      apiUrl: process.env.NUXT_ENV_API_URL,
      ssrUrl: process.env.NUXT_ENV_SSR_URL,
    },
  },
  vue: {
    compilerOptions: {
      isCustomElement: (tag) =>
        ['swiper-slide', 'swiper-container', 'country-flag', 'highlightjs'].includes(tag),
    },
  },
  i18n: {
    vueI18n: './i18n.config.js',
    locales: [
      {
        code: 'en',
        iso: 'en-US', // Will be used as "catchall" locale by default
      },
      {
        code: 'ja',
        iso: 'ja-JP',
      },
    ], // used in URL path prefix
    defaultLocale: process.env.NUXT_ENV_DEFAULT_LOCALE,
  },
  pinia: {
    storesDirs: ['./stores/**'],
  },
});
