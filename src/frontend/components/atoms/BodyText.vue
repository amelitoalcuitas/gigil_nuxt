<template>
  <p
    :class="`${variant} ${dense ? '' : 'mb-4'}`"
    :style="{ 'font-weight': isBold ? 700 : 400 }"
  >
    <slot />
  </p>
</template>

<script setup>
defineProps({
  variant: {
    type: String,
    default: 'text-body-1',
  },
  isBold: {
    type: Boolean,
    default: false,
  },
  dense: {
    type: Boolean,
    default: false,
  },
});
</script>
