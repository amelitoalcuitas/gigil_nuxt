<template>
  <v-dialog
    v-model="model"
    :width="width"
    persistent
  >
    <v-card>
      <div class="px-3 py-3 d-flex justify-space-between align-center">
        <slot name="title">
          <h3>{{ title }}</h3>
        </slot>

        <v-btn
          icon="mdi-close"
          variant="text"
          size="small"
          density="comfortable"
          @click="$emit('update:modelValue', false)"
        ></v-btn>
      </div>

      <v-divider></v-divider>

      <slot></slot>
    </v-card>
  </v-dialog>
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
    default: 400,
  },
});
</script>
