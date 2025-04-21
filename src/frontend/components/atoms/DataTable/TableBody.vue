<template>
  <tbody>
    <tr
      v-for="(row, index) in rows"
      :key="index"
    >
      <td
        v-for="(cell, key) in header"
        :key="key"
      >
        {{ getLabel(cell, row) }}
      </td>

      <td
        v-if="actions"
        class="actions"
      >
        <v-btn
          icon="mdi-delete"
          variant="text"
          size="x-small"
          color="error"
          @click="emit('delete', row.id)"
        ></v-btn>

        <v-btn
          icon="mdi-pencil"
          variant="text"
          size="x-small"
          @click="emit('edit', row.id)"
        ></v-btn>
      </td>
    </tr>

    <tr
      v-if="rows.length === 0"
      style="text-align: center"
    >
      <td :colspan="header.length + 1">
        {{ $t('table.no_data') }}
      </td>
    </tr>
  </tbody>
</template>

<script setup>
defineProps({
  header: {
    type: Array,
    default: () => [],
  },
  rows: {
    type: Array,
    default: () => [],
  },
  actions: {
    type: Boolean,
    default: true,
  },
});

const emit = defineEmits(['delete', 'edit']);

const getLabel = (cell, data) => {
  let label = data;
  // support value from objects e.g cell id: "status.name"  |  { "status": { "name": "Active"} }
  cell.id.split('.').forEach((key) => {
    label = label[key];
  });

  return label;
};
</script>

<style scoped>
table tbody tr td {
  font-size: 14px !important;
}

table tbody tr td.actions {
  text-align: right !important;
}

table tbody tr:last-child td {
  border-bottom: thin solid rgba(var(--v-border-color), var(--v-border-opacity));
}
</style>
