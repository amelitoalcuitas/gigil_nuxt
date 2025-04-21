<template>
  <div v-if="postalCode">
    <p class="text-body-1 mb-0">{{ formatPostal(postalCode) }}</p>
    <p class="text-body-1 mb-0">
      {{ prefecture }}
      {{ city }}
      {{ buildingName }}
    </p>
  </div>
</template>

<script setup>
defineProps({
  buildingName: {
    type: String,
    default: null,
  },
  city: {
    type: String,
    default: null,
  },
  prefecture: {
    type: String,
    default: null,
  },
  postalCode: {
    type: String,
    default: null,
  },
});

const formatPostal = (postalCode) => {
  const cleaned = postalCode.replace(/\D/g, '');
  const match = cleaned.match(/^(\d{3})(\d{4})$/);
  if (match) return `〒${match[1]}-${match[2]}`;
  else return 'Invalid Postal Code Provided.';
};
</script>
