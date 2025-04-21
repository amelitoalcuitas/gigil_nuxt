<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      class="mb-8"
    >
      Colors
    </Heading>

    <BodyText>
      These are the color palette for our current global theme. You can edit the values in
      <strong>src/frontend/plugins/vuetify.js</strong>
    </BodyText>

    <v-row class="mt-4">
      <v-col
        v-for="variant in variants"
        :key="variant"
        cols="12"
        md="4"
      >
        <v-card
          :color="variant"
          block
          class="pa-8"
          >{{ variant }} ({{ theme.current.value.colors[variant] }})</v-card
        >
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { useTheme } from 'vuetify';
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';

const theme = useTheme();
const variants = ['primary', 'secondary', 'error', 'info', 'success', 'warning'];
</script>
