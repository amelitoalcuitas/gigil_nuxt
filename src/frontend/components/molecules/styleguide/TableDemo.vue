<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      class="mb-8"
    >
      Table
    </Heading>

    <BodyText>
      Formatting Table using default Vuetify components can be tedious and has a lot of codes.
      Therefore, we will make use of our custom <strong>DataTable</strong> component created across
      the project.
    </BodyText>

    <Heading variant="h6">Table with No Toolbar and actions</Heading>
    <BodyText>
      If you want just plain table with data and has no Search Bar and Add, Edit, Delete Buttons.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="codeNoToolBarActions"
        class="my-8"
      ></highlightjs>
    </ClientOnly>

    <DataTable
      :header="headers"
      :data="users"
      :toolbar="false"
      :actions="false"
    />

    <Heading
      variant="h6"
      class="mt-8"
      >Table with Toolbar and actions</Heading
    >
    <BodyText>
      This will include a <strong>Search bar</strong> and <strong>Add New</strong> button in the top
      section of the DataTable.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="code"
        class="my-8"
      ></highlightjs>
    </ClientOnly>

    <DataTable
      :header="headers"
      :data="users"
      @add="handleAdd"
      @edit="handleEdit"
      @delete="handleDelete"
      @search="handleSearch"
    />
  </v-container>
</template>

<script setup>
import { faker } from '@faker-js/faker';
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';
import DataTable from '~/components/molecules/DataTable.vue';

const headers = [
  { id: 'id', label: 'ID' },
  { id: 'full_name', label: 'Full Name' },
  { id: 'email', label: 'Email Address' },
];

const users = [...Array(5)].map(() => ({
  id: faker.database.mongodbObjectId(),
  full_name: faker.name.firstName(),
  email: faker.internet.email(),
}));

const handleAdd = () => alert('You clicked "Add New"');
const handleEdit = (id) => alert(`Edit record ID: ${id}`);
const handleDelete = (id) => alert(`Delete record ID: ${id}`);
const handleSearch = (keyword) => alert(`Search Keyword is "${keyword}"`);

const code = `import DataTable from 'components/molecules/DataTable';\n
const headers = [
  { id: 'id', label: 'ID'},
  { id: 'full_name', label: 'Full Name'},
  { id: 'email', label: 'Email Address'},
];

const users = [
  { id: 1, full_name: 'John Doe', email: 'john@doe.com'},
  ...
  ...
];

<DataTable
  :header="headers"
  :data="users"
  @add="handleAdd"
  @edit="handleEdit"
  @delete="handleDelete"
  @search="handleSearch"
/>`;

const codeNoToolBarActions = `import DataTable from 'components/molecules/DataTable';\n
const headers = [
  { id: 'id', label: 'ID'},
  { id: 'full_name', label: 'Full Name'},
  { id: 'email', label: 'Email Address'},
];

const users = [
  { id: 1, full_name: 'John Doe', email: 'john@doe.com'},
  ...
  ...
];

<DataTable
  :header="headers"
  :data="users"
  :toolbar="false"
  :actions="false"
/>`;
</script>
