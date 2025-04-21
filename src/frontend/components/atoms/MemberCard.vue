<template>
  <v-card>
    <v-img
      class="align-end text-white"
      height="200"
      :src="avatar"
      cover
    />

    <v-card-item>
      <h4>{{ name }}</h4>
      <p class="text-body-2 mb-4">{{ role }}</p>
    </v-card-item>
  </v-card>
</template>

<script setup>
defineProps({
  name: {
    type: String,
    default: null,
  },
  avatar: {
    type: String,
    default: null,
  },
  role: {
    type: String,
    default: null,
  },
});
</script>
