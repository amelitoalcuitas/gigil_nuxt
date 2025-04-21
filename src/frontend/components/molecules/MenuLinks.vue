<template>
  <ul
    class="d-none d-md-flex ga-3 p-0 my-2 align-center"
    style="list-style: none"
  >
    <li
      v-for="(item, key) in items"
      :key="key"
    >
      <NuxtLink
        :to="localePath(item.url)"
        class="px-1 py-4 text-uppercase"
        style="font-size: 14px; text-decoration: none; color: inherit"
      >
        {{ $t(item.label) }}
      </NuxtLink>
    </li>
  </ul>
</template>

<script setup>
import { ref } from 'vue';

const localePath = useLocalePath();

const items = ref([
  { label: 'menu.about', url: '/about' },
  { label: 'menu.inquiry', url: '/inquiries' },
  { label: 'menu.faq', url: '/faq' },
  { label: 'menu.styleguide', url: '/styleguide' },
]);
</script>
