<template>
  <h1
    class="page-title"
    :style="`text-align: ${align}`"
  >
    {{ title }}
  </h1>

  <p
    v-if="subTitle?.length > 0"
    class="text-body-2"
    :style="`text-align: ${align}`"
  >
    {{ subTitle }}
  </p>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    default: null,
  },
  subTitle: {
    type: String,
    default: null,
  },
  align: {
    type: String,
    default: 'center',
  },
});
</script>

<style scoped>
.page-title {
  text-transform: uppercase;
  position: relative;
  font-weight: 700;
  margin-bottom: 32px;
  font-size: 1.625rem;
  line-height: 1.5;
}
.page-title:before {
  position: absolute;
  bottom: -16px;
  width: 60px;
  height: 4px;
  content: ' ';
  left: 50%;
  margin-left: -30px;
  background: #2196f3;
}
</style>
