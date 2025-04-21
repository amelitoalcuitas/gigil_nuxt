<template>
  <div class="mb-8">
    <ClientOnly>
      <TableToolbar
        v-if="toolbar"
        @search="handleSearch"
        @add="emit('add')"
      />

      <v-card>
        <v-table density="comfortable">
          <TableHead
            :head-cells="header"
            :actions="actions"
          />

          <TableBody
            :header="header"
            :rows="data"
            :actions="actions"
            @delete="handleClickDelete"
            @edit="handleClickEdit"
          />
        </v-table>

        <v-pagination
          v-model="currentPage"
          :length="total"
          rounded="circle"
          density="compact"
          @update:model-value="handleChangePage"
        ></v-pagination>
      </v-card>
    </ClientOnly>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import TableBody from '~/components/atoms/DataTable/TableBody.vue';
import TableHead from '~/components/atoms/DataTable/TableHead.vue';
import TableToolbar from '~/components/atoms/DataTable/TableToolbar.vue';

const emit = defineEmits(['search', 'add', 'delete', 'edit', 'changePage']);
const handleSearch = (keyword) => emit('search', keyword);
const handleClickDelete = (id) => emit('delete', id);
const handleClickEdit = (id) => emit('edit', id);
const handleChangePage = (page) => emit('changePage', page);

const props = defineProps({
  header: {
    type: Array,
    default: () => [],
  },
  data: {
    type: Array,
    default: () => [],
  },
  page: {
    type: Number,
    default: 1,
  },
  total: {
    type: Number,
    default: 1,
  },
  order: {
    type: String,
    default: 'desc',
  },
  sort: {
    type: String,
    default: 'id',
  },
  toolbar: {
    type: Boolean,
    default: true,
  },
  actions: {
    type: Boolean,
    default: true,
  },
});

const currentPage = ref(props.page);
</script>
