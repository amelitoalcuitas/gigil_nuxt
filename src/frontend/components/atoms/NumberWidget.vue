<template>
  <v-card>
    <v-card-item class="pa-8">
      <BodyText
        class="text-body-2"
        dense
        style="text-transform: uppercase !important"
      >
        {{ label }}
      </BodyText>
      <h3>{{ value }}</h3>
    </v-card-item>
  </v-card>
</template>

<script setup>
import BodyText from './BodyText.vue';

defineProps({
  label: {
    type: String,
    default: null,
  },
  value: {
    type: Number,
    default: 0,
  },
});
</script>

<style scoped>
h3 {
  font-size: 2.1422rem;
  margin: 0;
  padding: 0;
}
</style>
