<template>
  <v-expansion-panels variant="accordion">
    <v-expansion-panel
      v-for="(item, key) in items"
      :key="key"
    >
      <template #title>
        <h4>{{ item.header }}</h4>
      </template>
      <template #text>
        <p class="text-body-2">{{ item.content }}</p>
      </template>
    </v-expansion-panel>
  </v-expansion-panels>
</template>

<script setup>
defineProps({
  items: {
    type: Array,
    default: () => [],
  },
});
</script>
