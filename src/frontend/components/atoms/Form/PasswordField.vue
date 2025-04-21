<template>
  <div class="d-block">
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
      :type="hidePassword ? 'password' : 'text'"
      :placeholder="placeholder"
      variant="outlined"
      density="compact"
      class="d-block"
      :append-inner-icon="hidePassword ? 'mdi-eye-off' : 'mdi-eye'"
      @click:append-inner="hidePassword = !hidePassword"
      @input="$emit('update:modelValue', $event.target.value)"
    ></v-text-field>
  </div>
</template>

<script setup>
import { ref } from 'vue';
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
});

const {
  value: inputValue,
  meta,
  errorMessage,
} = useField(() => props.name, undefined, {
  syncVModel: true,
});

const hidePassword = ref(true);
</script>
