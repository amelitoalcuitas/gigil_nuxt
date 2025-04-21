<template>
  <v-container>
    <DataTable
      :header="headers"
      :data="users"
      :page="query.page"
      :total="meta.lastPage"
      :order="query.order"
      :sort="query.sort"
      @search="handleSearch"
      @add="handleAdd"
      @delete="handleDelete"
      @edit="handleEdit"
      @change-page="handleChangePage"
    />

    <AddEditModal
      v-model="open"
      :user="user"
      :title="title"
      @close="open = false"
      @save="handleSave"
    />
  </v-container>
</template>

<script setup>
import { ref, watch } from 'vue';
import DataTable from '~/components/molecules/DataTable.vue';
import AddEditModal from '~/components/molecules/users/AddEditModal.vue';

definePageMeta({
  middleware: ['auth'],
  layout: 'authenticated',
});

useHead({
  title: 'Users',
});

const { t } = useI18n();
const { $api, $toast } = useNuxtApp();
const users = ref([]);
const query = ref({
  keyword: '',
  page: 1,
  order: 'desc',
  sort: 'id',
  limit: 10,
});
const meta = ref({
  total: 0,
  currentPage: 1,
  lastPage: 1,
  perPage: 10,
  firstPageUrl: null,
  previousPageUrl: null,
  nextPageUrl: null,
  url: '/',
});
const open = ref(false);
const user = ref(null);
const title = ref('');

const headers = [
  {
    id: 'id',
    numeric: false,
    disablePadding: false,
    label: 'ID',
  },
  {
    id: 'first_name',
    numeric: false,
    disablePadding: false,
    label: t('pages.users.first_name'),
  },
  {
    id: 'last_name',
    numeric: false,
    disablePadding: false,
    label: t('pages.users.last_name'),
  },
  {
    id: 'email',
    numeric: false,
    disablePadding: false,
    label: t('pages.users.email_address'),
  },
  {
    id: 'status.name',
    numeric: false,
    disablePadding: false,
    label: t('pages.users.status'),
  },
];

const fetchUsers = async () => {
  const { data, meta: newMeta } = await $api
    .get(`/users?${new URLSearchParams(query.value).toString()}`)
    .then(({ data }) => data);
  users.value = data;
  meta.value = newMeta;
};

const handleChangePage = (page) => {
  query.value = { ...query.value, ...{ page } };
};

const handleSearch = (keyword) => {
  query.value = { ...query.value, ...{ keyword, page: 1 } };
};

const handleAdd = () => {
  user.value = null;
  title.value = t('pages.users.add_user');
  open.value = true;
};

const handleDelete = async (id) => {
  if (confirm(t('pages.users.delete_confirmation'))) {
    await $api.delete(`/users/${id}`);
    await fetchUsers();
    $toast(t('pages.users.user_deleted'), { type: 'success' });
  }
};

const handleEdit = async (id) => {
  user.value = await $api.get(`/users/${id}`).then(({ data }) => data.data);
  title.value = t('pages.users.edit_user');
  open.value = true;
};

const handleSave = async (response) => {
  if (!user.value) {
    await fetchUsers();
    open.value = false;
    $toast(t('pages.users.user_created'), { type: 'success' });
    return;
  }

  const updatedList = [...users.value];
  const index = updatedList.findIndex((row) => parseInt(row.id) === parseInt(response.id));
  updatedList[index] = response;
  users.value = updatedList;
  open.value = false;
  $toast(t('pages.users.user_updated'), { type: 'success' });
};

onMounted(() => fetchUsers());
watch(query, () => fetchUsers());
</script>
