<template>
  <v-navigation-drawer
    :permanent="model"
    :location="location"
    :scrim="false"
    :width="width"
  >
    <template #prepend>
      <div class="px-3 py-3 d-flex justify-space-between align-center">
        <v-btn
          icon="mdi-close"
          variant="text"
          size="small"
          density="comfortable"
          @click="$emit('update:modelValue', false)"
        ></v-btn>

        <slot name="title">
          <h3>{{ title }}</h3>
        </slot>

        <div></div>
      </div>
    </template>

    <v-divider></v-divider>

    <slot></slot>
  </v-navigation-drawer>
</template>

<script setup>
defineEmits(['update:modelValue']);

defineProps({
  title: {
    type: String,
    default: '',
  },
  width: {
    type: Number,
    default: 720,
  },
  location: {
    type: String,
    default: 'right',
  },
});
</script>
