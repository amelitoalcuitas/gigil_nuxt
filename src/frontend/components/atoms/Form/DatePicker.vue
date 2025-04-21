<template>
  <div class="d-block w-100">
    <label
      :for="name"
      class="text-body-2 d-block font-weight-bold text-uppercase mb-1"
      :class="errorMessage ? 'text-error' : ''"
    >
      {{ label }}
    </label>

    <v-dialog width="auto">
      <template #activator="{ props: dialogProps }">
        <v-text-field
          v-model="selectedDate"
          :name="name"
          :error="errorMessage && meta.touched"
          :hint="errorMessage && meta.touched ? errorMessage : ''"
          persistent-hint
          density="compact"
          variant="outlined"
          hide-details="auto"
          prepend-inner-icon="mdi-calendar"
          :placeholder="placeholder"
          readonly
          clearable
          v-bind="dialogProps"
        ></v-text-field>
      </template>

      <template #default="{ isActive }">
        <v-date-picker
          v-model="inputValue"
          :color="color"
          @update:model-value="isActive.value = false"
        ></v-date-picker>
      </template>
    </v-dialog>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import { useField } from 'vee-validate';

const props = defineProps({
  type: {
    type: String,
    default: 'text',
  },
  value: {
    type: String,
    default: '',
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
    default: 'Please select',
  },
  modelValue: {
    type: Date,
    default: null,
  },
  color: {
    type: String,
    default: 'primary',
  },
  format: {
    type: String,
    default: 'mm/dd/yyyy',
  },
});

const {
  value: inputValue,
  meta,
  errorMessage,
} = useField(() => props.name, undefined, {
  syncVModel: true,
});

const selectedDate = ref(null);

watch(inputValue, (value) => {
  selectedDate.value = new Date(value).toLocaleDateString('en-US');
});
</script>
