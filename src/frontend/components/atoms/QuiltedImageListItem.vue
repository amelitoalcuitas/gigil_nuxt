<template>
  <v-col :cols="cols">
    <v-img
      :src="url"
      cover
      height="100%"
    />
  </v-col>
</template>

<script setup>
defineProps({
  cols: {
    type: Number,
    default: 12,
  },
  url: {
    type: String,
    default: null,
  },
});
</script>
