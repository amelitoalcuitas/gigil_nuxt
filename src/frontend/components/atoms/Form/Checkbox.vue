<template>
  <div class="d-block">
    <v-checkbox
      v-model="inputValue"
      :name="name"
      density="comfortable"
      :error="errorMessage && meta.touched"
      :hint="errorMessage && meta.touched ? errorMessage : ''"
      hide-details="auto"
      persistent-hint
      :color="color"
      @input="$emit('update:inputValue', $event.target.value)"
    >
      <template #label>
        <slot name="label">
          {{ label }}
        </slot>
      </template>
    </v-checkbox>
  </div>
</template>

<script setup>
import { useField } from 'vee-validate';
defineEmits(['update:inputValue']);

const props = defineProps({
  label: {
    type: String,
    default: undefined,
  },
  value: {
    type: String,
    default: undefined,
  },
  checked: {
    type: Boolean,
    default: false,
  },
  name: {
    type: String,
    required: true,
  },
  modelValue: {
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
} = useField(props.name, undefined, {
  initialValue: false,
  syncVModel: true,
});
</script>
