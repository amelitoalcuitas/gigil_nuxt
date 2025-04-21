<template>
  <div
    class="hero-image"
    :style="`background-image: url(${image}); height: ${height}`"
  >
    <slot />
  </div>
</template>

<script setup>
defineProps({
  image: {
    type: String,
    default: null,
  },
  height: {
    type: String,
    default: '100vh',
  },
});
</script>

<style scoped>
.hero-image {
  background-position: center;
  background-repeat: none;
  background-size: cover;
}
</style>
