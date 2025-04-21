<template>
  <div class="d-block w-100">
    <label
      :for="name"
      class="text-body-2 d-block font-weight-bold text-uppercase mb-1"
      :class="errorMessage ? 'text-error' : ''"
    >
      {{ label }}
    </label>

    <v-text-field
      :id="name"
      v-model="inputValue"
      :error="errorMessage && meta.touched"
      :hint="errorMessage && meta.touched ? errorMessage : ''"
      hide-details="auto"
      persistent-hint
      :name="name"
      :type="type"
      :placeholder="placeholder"
      variant="outlined"
      density="compact"
      class="d-block"
      @input="$emit('update:modelValue', $event.target.value)"
    ></v-text-field>
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
    default: '',
  },
  modelValue: {
    type: String,
    default: null,
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
