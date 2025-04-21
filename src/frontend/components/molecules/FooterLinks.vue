<template>
  <ul>
    <li
      v-for="(item, key) in items"
      :key="key"
    >
      <NuxtLink :to="localePath(item.url)">
        {{ $t(item.label) }}
      </NuxtLink>
    </li>
  </ul>
</template>

<script setup>
const localePath = useLocalePath();

defineProps({
  items: {
    type: Array,
    default: () => [],
  },
});
</script>

<style scoped>
ul {
  list-style-type: none;
}

ul li a {
  text-decoration: none;
  color: inherit;
  font-size: 12px;
}
</style>
