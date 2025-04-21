import { defineStore } from 'pinia';

export const useProfileStore = defineStore('profile', {
  state: () => ({ user: null }),
  actions: {
    setProfile(user) {
      this.user = user;
    },
  },
});
