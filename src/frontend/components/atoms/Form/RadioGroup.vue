<template>
  <div class="d-block w-100">
    <label
      :for="name"
      class="text-body-2 d-block font-weight-bold text-uppercase mb-1"
      :class="errorMessage ? 'text-error' : ''"
    >
      {{ label }}
    </label>

    <v-radio-group
      v-model="inputValue"
      :name="name"
      :error="errorMessage && meta.touched"
      :hint="errorMessage && meta.touched ? errorMessage : ''"
      :inline="inline"
      :color="color"
      hide-details="auto"
      persistent-hint
      @input="$emit('update:modelValue', $event.target.value)"
    >
      <v-radio
        v-for="(option, key) in options"
        :key="key"
        :label="option.label"
        :value="option.value"
      >
      </v-radio>
    </v-radio-group>
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
  inline: {
    type: Boolean,
    default: false,
  },
  color: {
    type: String,
    default: 'primary',
  },
});

const {
  value: inputValue,
  meta,
  errorMessage,
} = useField(() => props.name, undefined, {
  initialValue: null,
  syncVModel: true,
});
</script>
