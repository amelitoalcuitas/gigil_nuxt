<template>
  <div
    class="py-8"
    :style="`background: ${colors.blueGrey.darken4}; color: ${colors.blueGrey.lighten4}`"
  >
    <v-container>
      <v-row>
        <v-col>
          <v-img
            src="/static/images/project-logo.png"
            width="100"
          />
          <span class="text-body-2">&copy; {{ currentYear }} {{ siteTitle }}.</span>
        </v-col>

        <v-col>
          <h3 class="mb-3">{{ $t('labels.navigation') }}</h3>
          <FooterLinks :items="navigation" />
        </v-col>

        <v-col>
          <h3 class="mb-3">{{ $t('labels.resources') }}</h3>
          <FooterLinks :items="resources" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script setup>
import colors from 'vuetify/util/colors';
import FooterLinks from '~/components/molecules/FooterLinks.vue';

const runtimeConfig = useRuntimeConfig();
const siteTitle = runtimeConfig.public.appName;
const currentYear = new Date().getFullYear();
const navigation = [
  { label: 'menu.privacy_policy', url: '/privacy-policy' },
  { label: 'menu.faq', url: '/faq' },
  { label: 'menu.terms', url: '/terms' },
];
const resources = [
  { label: 'menu.styleguide', url: '/styleguide' },
  { label: 'menu.api_reference', url: '/#' },
  { label: 'menu.support', url: '/#' },
];
</script>
