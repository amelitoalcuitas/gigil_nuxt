<template>
  <div class="d-block w-100">
    <label
      :for="name"
      class="text-body-2 d-block font-weight-bold text-uppercase mb-1"
      :class="errorMessage ? 'text-error' : ''"
    >
      {{ label }}
    </label>

    <v-select
      v-model="inputValue"
      :name="name"
      :error="errorMessage && meta.touched"
      :hint="errorMessage && meta.touched ? errorMessage : ''"
      :items="options"
      :placeholder="placeholder"
      item-title="label"
      item-value="value"
      variant="outlined"
      density="compact"
      hide-details="auto"
      persistent-hint
      single-line
      clearable
      @input="$emit('update:modelValue', $event.target.value)"
    ></v-select>
  </div>
</template>

<script setup>
import { useField } from 'vee-validate';
defineEmits(['update:modelValue']);

const props = defineProps({
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
    default: '',
  },
  modelValue: {
    type: String,
    default: null,
  },
  options: {
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
