<template>
  <v-navigation-drawer
    permanent
    :rail="!open"
  >
    <v-list color="primary">
      <v-list-item
        v-for="link in links"
        :key="link"
        :prepend-icon="link.icon"
        :title="$t(link.label)"
        :to="localePath(link.path)"
        class="text-body-2"
        link
      />
    </v-list>
  </v-navigation-drawer>
</template>

<script setup>
defineProps({
  open: {
    type: Boolean,
    default: false,
  },
});
const localePath = useLocalePath();

const links = [
  {
    label: 'menu.dashboard',
    path: '/dashboard',
    icon: 'mdi-view-dashboard',
  },
  {
    label: 'menu.users',
    path: '/users',
    icon: 'mdi-account-multiple',
  },
  {
    label: 'menu.integrations',
    path: '/integrations',
    icon: 'mdi-layers',
  },
];
</script>
