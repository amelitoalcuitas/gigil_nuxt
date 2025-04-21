<script setup>
import { register } from 'swiper/element/bundle';
import ReviewCard from '~/components/atoms/ReviewCard.vue';
register();

defineProps({
  reviews: {
    type: Array,
    default: () => [],
  },
});
</script>

<template>
  <swiper-container
    :slides-per-view="3"
    :space-between="30"
    :navigation="true"
    :breakpoints="{
      425: {
        slidesPerView: 1,
      },
      768: {
        slidesPerView: 3,
      },
      1024: {
        slidesPerView: 3,
      },
    }"
  >
    <swiper-slide
      v-for="(review, key) in reviews"
      :key="key"
    >
      <ReviewCard
        :avatar="review.avatar"
        :name="review.name"
        :comment="review.comment"
        :rating="review.rating"
      />
    </swiper-slide>
  </swiper-container>
</template>
