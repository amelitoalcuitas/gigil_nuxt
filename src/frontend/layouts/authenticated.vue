<template>
  <v-app>
    <v-layout>
      <Navbar
        :open="open"
        @toggle-sidebar="handleToggle"
      />

      <Sidebar :open="open" />

      <v-main>
        <v-container>
          <slot />

          <Footer />
        </v-container>
      </v-main>
    </v-layout>
  </v-app>
</template>

<script setup>
import { ref } from 'vue';
import Footer from '~/components/organisms/Authenticated/Footer.vue';
import Navbar from '~/components/organisms/Authenticated/Navbar.vue';
import Sidebar from '~/components/organisms/Authenticated/Sidebar.vue';

const open = ref(false);
const handleToggle = () => (open.value = !open.value);

useHead({
  meta: [
    // disable SEO Crawlers on Authenticated Pages.
    { property: 'name', content: 'NOINDEX, NOFOLLOW' },
  ],
});
</script>
