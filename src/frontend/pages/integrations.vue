<template>
  <v-container
    class="pt-6 pb-8"
    fluid
  >
    <PageTitle :title="$t('labels.integrations')" />

    <div class="py-8">
      <v-row>
        <v-col
          v-for="(integration, index) in integrations"
          :key="index"
          cols="12"
          sm="4"
        >
          <v-card class="mx-auto">
            <v-img
              class="align-end text-white"
              height="200"
              :src="integration.image"
              cover
            ></v-img>

            <v-card-title>{{ integration.name }}</v-card-title>
            <v-card-subtitle>{{ integration.category }}</v-card-subtitle>

            <v-card-actions class="mt-4">
              <v-btn color="primary">{{ $t('labels.settings') }}</v-btn>
              <v-btn color="primary">{{ $t('labels.documentation') }}</v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </div>
  </v-container>
</template>

<script setup>
import PageTitle from '~/components/atoms/PageTitle.vue';

definePageMeta({
  middleware: ['auth'],
  layout: 'authenticated',
});

const { t } = useI18n();

useHead({
  title: t('menu.integrations'),
});

const integrations = [
  {
    name: 'Backlog',
    category: 'Project Management',
    image: '/static/images/backlog.svg',
  },
  {
    name: 'Gitlab',
    category: 'Source Control',
    image: '/static//images/gitlab.svg',
  },
  {
    name: 'Slack',
    category: 'Communication',
    image: '/static/images/slack.svg',
  },
];
</script>
