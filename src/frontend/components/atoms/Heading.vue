<template>
  <component
    :is="variant"
    :class="`text-${variant} text-${align} font-weight-bold`"
  >
    <slot />
  </component>
</template>

<script setup>
defineProps({
  variant: {
    type: String,
    default: 'h1',
  },
  align: {
    type: String,
    default: 'left',
  },
});
</script>
