<template>
  <BodyText>
    <component
      :is="`span`"
      v-if="isKanji === false"
      >¥</component
    >
    <span>{{
      Number(amount).toLocaleString('ja-JP', {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      })
    }}</span>
    <component
      :is="`span`"
      v-if="isKanji === true"
      >円</component
    >
  </BodyText>
</template>

<script setup>
import BodyText from '~/components/atoms/BodyText.vue';

defineProps({
  amount: {
    type: Number,
    default: 0,
  },
  isKanji: {
    type: Boolean,
    default: false,
  },
});
</script>
