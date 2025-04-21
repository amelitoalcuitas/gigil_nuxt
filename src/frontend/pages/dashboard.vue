<template>
  <v-container class="pt-6 pb-8">
    <PageTitle
      :title="$t('pages.dashboard.main_heading')"
      :sub-title="$t('pages.dashboard.sub_heading')"
    />

    <div class="py-8">
      <v-row>
        <v-col
          v-for="(widget, index) in widgets"
          :key="index"
          cols="12"
          sm="4"
        >
          <NumberWidget
            :label="widget.label"
            :value="widget.value"
          />
        </v-col>
      </v-row>
    </div>

    <LineChart />
  </v-container>
</template>

<script setup>
import PageTitle from '~/components/atoms/PageTitle.vue';
import NumberWidget from '~/components/atoms/NumberWidget.vue';
import LineChart from '~/components/atoms/LineChart.vue';

definePageMeta({
  middleware: ['auth'],
  layout: 'authenticated',
});

const { t } = useI18n();

useHead({
  title: t('menu.dashboard'),
});

const widgets = [
  { label: t('pages.dashboard.new_users'), value: 35 },
  {
    label: t('pages.dashboard.total_sales'),
    value: 35750,
  },
  {
    label: t('pages.dashboard.total_orders'),
    value: 540,
  },
];
</script>
