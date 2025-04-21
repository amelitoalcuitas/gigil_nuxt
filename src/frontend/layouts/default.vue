<template>
  <v-app>
    <Navbar />
    <div class="mt-16">
      <slot />
    </div>
    <Footer />
  </v-app>
</template>

<script setup>
import Footer from '~/components/organisms/Guest/Footer.vue';
import Navbar from '~/components/organisms/Guest/Navbar.vue';
</script>
