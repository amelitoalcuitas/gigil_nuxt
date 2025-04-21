<template>
  <div class="py-4 text-center">
    <BodyText variant="text-body-2"> &copy; {{ currentYear }} {{ siteTitle }}. </BodyText>
  </div>
</template>

<script setup>
import BodyText from '~/components/atoms/BodyText.vue';

const runtimeConfig = useRuntimeConfig();
const siteTitle = runtimeConfig.public.appName;
const currentYear = new Date().getFullYear();
</script>
