<template>
  <v-container class="py-16">
    <PageTitle
      title="Base Template Styleguide"
      sub-title="This is the Standard Styleguide used across all pages for this Application."
    />

    <v-card class="mt-8">
      <v-tabs
        v-model="currentTab"
        style="border-bottom: thin solid rgba(var(--v-border-color), var(--v-border-opacity))"
      >
        <v-tab
          v-for="tab in tabs"
          :key="tab"
        >
          {{ tab }}
        </v-tab>
      </v-tabs>

      <v-card-text>
        <v-window v-model="currentTab">
          <v-window-item value="Typography">
            <TypographyDemo />
          </v-window-item>

          <v-window-item value="Colors">
            <PaletteDemo />
          </v-window-item>

          <v-window-item value="Buttons">
            <ButtonDemo />
          </v-window-item>

          <v-window-item value="Form Components">
            <FormComponentsDemo />
          </v-window-item>

          <v-window-item value="Form Components">
            <FormValidationDemo />
          </v-window-item>

          <v-window-item value="Table">
            <TableDemo />
          </v-window-item>

          <v-window-item value="Modal">
            <ModalDemo />
          </v-window-item>

          <v-window-item value="Accordion">
            <AccordionDemo />
          </v-window-item>

          <v-window-item value="Formatter">
            <FormatterDemo />
          </v-window-item>
        </v-window>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script setup>
import { ref } from 'vue';
import PageTitle from '~/components/atoms/PageTitle.vue';
import PaletteDemo from '~/components/molecules/styleguide/PaletteDemo.vue';
import TypographyDemo from '~/components/molecules/styleguide/TypographyDemo.vue';
import ButtonDemo from '~/components/molecules/styleguide/ButtonDemo.vue';
import FormComponentsDemo from '~/components/molecules/styleguide/FormComponentsDemo.vue';
import FormatterDemo from '~/components/molecules/styleguide/FormatterDemo.vue';
import AccordionDemo from '~/components/molecules/styleguide/AccordionDemo.vue';
import TableDemo from '~/components/molecules/styleguide/TableDemo.vue';
import FormValidationDemo from '~/components/molecules/styleguide/FormValidationDemo.vue';
import ModalDemo from '~/components/molecules/styleguide/ModalDemo.vue';

const currentTab = ref('Typography');

const tabs = [
  'Typography',
  'Colors',
  'Buttons',
  'Form Components',
  'Form Validation',
  'Table',
  'Modal',
  'Accordion',
  'Formatter',
];

const { t } = useI18n();

useHead({
  title: t('menu.styleguide'),
});
</script>
