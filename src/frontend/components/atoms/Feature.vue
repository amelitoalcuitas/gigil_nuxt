<script setup>
defineProps({
  title: {
    type: String,
    default: '',
  },
  description: {
    type: String,
    default: '',
  },
  image: {
    type: String,
    default: '',
  },
  isReverse: {
    type: Boolean,
    default: false,
  },
});
</script>

<template>
  <v-container class="py-8">
    <v-row>
      <v-col
        :order="isReverse ? 2 : 1"
        cols="12"
        sm="6"
      >
        <img
          :src="image"
          :alt="title"
          class="mx-auto"
          style="width: 100%"
        />
      </v-col>

      <v-col
        :order="isReverse ? 1 : 2"
        cols="12"
        sm="6"
      >
        <div
          class="mx-auto"
          style="width: 100%; max-width: 420px"
        >
          <h5
            class="mb-3 text-bold"
            style="font-size: 24px"
          >
            {{ title }}
          </h5>
          <p style="font-size: 14px">{{ description }}</p>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>
