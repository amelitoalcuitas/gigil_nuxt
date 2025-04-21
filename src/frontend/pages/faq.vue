<template>
  <v-container class="mt-8">
    <PageTitle
      :title="$t('pages.faq.heading')"
      :sub-title="$t('pages.faq.sub_heading')"
    />

    <div class="my-8">
      <ClientOnly>
        <Accordion :items="questions" />
      </ClientOnly>
    </div>
  </v-container>
</template>

<script setup>
import { faker } from '@faker-js/faker';
import PageTitle from '~/components/atoms/PageTitle.vue';
import Accordion from '~/components/molecules/Accordion.vue';

const { t } = useI18n();

useHead({
  title: t('menu.faq'),
});

const questions = [...Array(10)].map(() => ({
  header: `${faker.lorem.words(5)}?`,
  content: faker.lorem.paragraphs(2, '\n'),
}));
</script>
