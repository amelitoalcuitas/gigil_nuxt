<script setup>
defineProps({
  title: {
    type: String,
    default: '',
  },
  isFullWidth: {
    type: Boolean,
    default: false,
  },
  isWhiteBg: {
    type: Boolean,
    default: false,
  },
});
</script>

<template>
  <section
    class="py-16"
    :style="`background: ${isWhiteBg ? 'white' : ''}`"
  >
    <v-container :fluid="isFullWidth">
      <h4
        class="text-center"
        style="font-size: 30px; margin-bottom: 32px"
      >
        {{ title }}
      </h4>
      <slot />
    </v-container>
  </section>
</template>
