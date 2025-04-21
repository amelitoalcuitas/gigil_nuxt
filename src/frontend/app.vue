<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>

<script setup>
const { $config } = useNuxtApp();
const { appName } = $config.public;

useHead({
  titleTemplate: (titleChunk) => {
    return titleChunk ? `${titleChunk} | ${appName}` : appName;
  },
  link: [
    { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
    { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: true },
    {
      rel: 'stylesheet',
      href: 'https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&display=swap',
    },
  ],
  meta: [
    // Default Sitewide description
    { name: 'description', content: 'This is a boilerplate for React + Laravel Applications.' },
    { 'http-equiv': 'Content-Type', content: 'text/html; charset=utf-8' },
  ],
});
</script>
