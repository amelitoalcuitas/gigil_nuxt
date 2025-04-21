export default defineNuxtRouteMiddleware(async (to) => {
  const access_token = useCookie('access_token');
  const runtimeConfig = useRuntimeConfig();
  const { apiUrl } = runtimeConfig.public;
  const store = useProfileStore();

  if (!access_token.value) {
    return navigateTo(`/login?redirect_to=${to.fullPath}`);
  }

  // get user details
  const user = await fetch(`${apiUrl}/profile`, {
    headers: { Authorization: `Bearer ${access_token.value}` },
  })
    .then((res) => {
      if (!res.ok) throw Error(res.statusText);
      return res.json();
    })
    .then(({ data }) => data)
    .catch(() => {});

  if (user) store.setProfile(user);
});
