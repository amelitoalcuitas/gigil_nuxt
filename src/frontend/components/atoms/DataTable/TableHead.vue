<template>
  <thead>
    <tr>
      <th
        v-for="(cell, index) in headCells"
        :key="index"
      >
        {{ cell.label }}
      </th>

      <th
        v-if="actions"
        class="actions"
      >
        {{ $t('labels.action') }}
      </th>
    </tr>
  </thead>
</template>

<script setup>
defineProps({
  headCells: {
    type: Array,
    default: () => [],
  },
  order: {
    type: String,
    default: 'desc',
  },
  orderBy: {
    type: String,
    default: 'id',
  },
  actions: {
    type: Boolean,
    default: true,
  },
});
</script>

<style scoped>
table thead tr th {
  font-size: 14px !important;
  font-weight: 700 !important;
  text-transform: uppercase;
}

table thead tr th.actions {
  text-align: right !important;
}
</style>
