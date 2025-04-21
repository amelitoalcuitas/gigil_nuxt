<template>
  <div class="d-block w-100">
    <label
      :for="name"
      class="text-body-2 d-block font-weight-bold text-uppercase mb-1"
      :class="errorMessage ? 'text-error' : ''"
    >
      {{ label }}
    </label>

    <v-file-input
      v-model="inputValue"
      :name="name"
      :error="errorMessage && meta.touched"
      :hint="errorMessage && meta.touched ? errorMessage : ''"
      variant="outlined"
      density="compact"
      hide-details="auto"
      show-size
      persistent-hint
      :placeholder="placeholder"
      @input="emit('update:modelValue', $event.target.value)"
    ></v-file-input>
  </div>
</template>

<script setup>
import { useField } from 'vee-validate';
defineEmits(['update:modelValue']);

const props = defineProps({
  type: {
    type: String,
    default: 'text',
  },
  value: {
    type: String,
    default: undefined,
  },
  name: {
    type: String,
    required: true,
  },
  label: {
    type: String,
    required: true,
  },
  placeholder: {
    type: String,
    default: 'Select a file',
  },
  modelValue: {
    type: Array,
    default: () => [],
  },
});

const {
  value: inputValue,
  meta,
  errorMessage,
} = useField(() => props.name, undefined, {
  syncVModel: true,
});
</script>
