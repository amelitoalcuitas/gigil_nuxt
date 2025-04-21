<template>
  <v-menu location="bottom">
    <template #activator="{ props }">
      <v-btn
        color="primary"
        v-bind="props"
        icon="mdi-menu"
        class="d-flex d-md-none"
      />
    </template>

    <v-card style="background: white; width: 250px">
      <ul
        class="d-flex flex-column p-0 my-2"
        style="list-style: none"
      >
        <li
          v-for="(item, key) in items"
          :key="key"
        >
          <NuxtLink
            :to="localePath(item.url)"
            class="px-3 py-3 text-uppercase d-block"
            style="font-size: 14px; text-decoration: none; color: inherit"
          >
            {{ $t(item.label) }}
          </NuxtLink>
        </li>

        <li class="px-3 mb-3">
          <v-btn
            to="/signup"
            variant="outlined"
            nuxt
            block
          >
            {{ $t('labels.signup') }}
          </v-btn>
        </li>

        <li class="px-3">
          <v-btn
            to="/login"
            variant="flat"
            color="primary"
            nuxt
            block
          >
            {{ $t('labels.login') }}
          </v-btn>
        </li>
      </ul>
    </v-card>
  </v-menu>
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
