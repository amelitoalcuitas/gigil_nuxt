import axios from 'axios';

export default defineNuxtPlugin((nuxtApp) => {
  let api = axios;
  api.defaults.baseURL = nuxtApp.$config.public.apiUrl;

  const access_token = useCookie('access_token');
  if (access_token) api.defaults.headers.common['Authorization'] = `Bearer ${access_token.value}`;

  return {
    provide: {
      api: api,
    },
  };
});
