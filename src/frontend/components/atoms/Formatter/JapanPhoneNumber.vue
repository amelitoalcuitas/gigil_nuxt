<template>
  <BodyText>{{ formatPhone(number) }}</BodyText>
</template>

<script setup>
import BodyText from '~/components/atoms/BodyText.vue';

defineProps({
  number: {
    type: String,
    default: null,
  },
});

const formatPhone = (number) => {
  const cleaned = number.replace(/\D/g, '');
  const match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
  if (match) return `${match[1]}-${match[2]}-${match[2]}`;
  else return 'Invalid Phone Number Provided.';
};
</script>
