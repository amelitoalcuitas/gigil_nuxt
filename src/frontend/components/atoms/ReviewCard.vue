<script setup>
defineProps({
  avatar: {
    type: String,
    default: '',
  },
  name: {
    type: String,
    default: '',
  },
  comment: {
    type: String,
    default: '',
  },
  rating: {
    type: Number,
    default: 0,
  },
});
</script>

<template>
  <v-card
    class="d-flex flex-column justify-center align-center py-8 px-8"
    style="min-height: 220px"
  >
    <v-avatar size="48px">
      <v-img
        :alt="name"
        :src="avatar"
        cover
      />
    </v-avatar>
    <h4>{{ name }}</h4>

    <v-rating
      readonly
      :length="5"
      :size="24"
      :model-value="rating"
      color="warning"
      active-color="warning"
    />

    <p class="text-center text-caption mt-4">{{ comment }}</p>
  </v-card>
</template>
