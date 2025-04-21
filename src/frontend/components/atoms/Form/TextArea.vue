<template>
  <div class="d-block w-100">
    <label
      :for="name"
      class="text-body-2 d-block font-weight-bold text-uppercase mb-1"
      :class="errorMessage ? 'text-error' : ''"
    >
      {{ label }}
    </label>

    <v-textarea
      :id="name"
      v-model="inputValue"
      :name="name"
      :error="errorMessage && meta.touched"
      :hint="errorMessage && meta.touched ? errorMessage : ''"
      hide-details="auto"
      persistent-hint
      :placeholder="placeholder"
      variant="outlined"
      density="compact"
      class="d-block"
      :rows="rows"
      @input="$emit('update:modelValue', $event.target.value)"
    ></v-textarea>
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
  rows: {
    type: Number,
    default: 3,
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
