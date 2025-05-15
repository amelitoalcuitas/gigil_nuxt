// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },

  ssr: false,

  // disable sourcemap so the terminal warnings go away
  sourcemap: {
    client: false,
    server: false
  },

  css: ['~/assets/css/main.css'],

  modules: ['@nuxt/eslint', '@nuxt/ui-pro', '@vueuse/nuxt'],

  routeRules: {
    '/api/**': {
      cors: true
    }
  },

  future: {
    compatibilityVersion: 4
  },

  compatibilityDate: '2024-07-11',

  runtimeConfig: {
    public: {
      appName: process.env.NUXT_ENV_SITE_TITLE,
      clientId: process.env.NUXT_ENV_CLIENT_ID,
      clientSecret: process.env.NUXT_ENV_CLIENT_SECRET,
      siteUrl: process.env.NUXT_ENV_SITE_URL,
      apiUrl: process.env.NUXT_ENV_API_URL,
      ssrUrl: process.env.NUXT_ENV_SSR_URL
    }
  }
})
