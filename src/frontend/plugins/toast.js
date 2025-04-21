import Vue3Toastify, { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

export default defineNuxtPlugin((nuxtApp) => {
  const config = {
    autoClose: 3000,
    position: 'bottom-right',
  };
  nuxtApp.vueApp.use(Vue3Toastify, config);

  return {
    provide: { toast },
  };
});
