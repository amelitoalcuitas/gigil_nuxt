<template>
  <div>
    <v-container
      fluid
      class="d-flex flex-column justify-center align-center"
      style="
        background-image: url('/static/images/landing-cover.jpg');
        background-size: cover;
        height: calc(100vh - 100px);
      "
    >
      <h2
        class="text-white-shadow"
        style="font-size: 42px"
      >
        {{ $t('pages.landing.main_heading') }}
      </h2>

      <h5
        class="text-white-shadow mb-4"
        style="font-size: 24px"
      >
        {{ $t('pages.landing.sub_heading') }}
      </h5>

      <v-btn
        variant="outlined"
        color="white"
        size="x-large"
        rounded="xl"
      >
        {{ $t('labels.get_started') }}
      </v-btn>
    </v-container>

    <Section :title="$t('pages.landing.why_heading')">
      <Feature
        v-for="(feature, key) in features"
        :key="key"
        :title="$t(feature.title)"
        :description="$t(feature.description)"
        :image="feature.image"
        :is-reverse="feature.isReverse"
      />
    </Section>

    <Section
      :title="$t('pages.landing.our_customers_heading')"
      :is-white-bg="true"
    >
      <v-row>
        <v-col
          v-for="(client, key) in clients"
          :key="key"
          cols="12"
          sm="4"
          md="2"
        >
          <img
            :src="client.logo"
            :alt="client.name"
            style="width: 100%"
          />
        </v-col>
      </v-row>
    </Section>

    <Section :title="$t('pages.landing.reviews_heading')">
      <ClientOnly>
        <ReviewSlider :reviews="reviews" />
      </ClientOnly>
    </Section>

    <CallToAction />
  </div>
</template>

<script setup>
import { faker } from '@faker-js/faker';
import Feature from '~/components/atoms/Feature.vue';
import Section from '~/components/atoms/Section.vue';
import ReviewSlider from '~/components/molecules/ReviewSlider.vue';
import CallToAction from '~/components/molecules/CallToAction.vue';

const {
  $config: {
    public: { siteUrl },
  },
} = useNuxtApp();
const { t } = useI18n();
const route = useRoute();

useHead({
  title: t('menu.home'),
  description: 'Home Page Description.',
  meta: [
    // facebook
    { property: 'og:type', content: 'website' },
    { property: 'og:url', content: `${siteUrl}${route.fullPath}` },
    { property: 'og:title', content: t('menu.home') },
    { property: 'og:description', content: 'Home Page Description.' },
    { property: 'og:image', content: `${siteUrl}/static/images/project-logo.png` },
    // twitter
    { property: 'twitter:card', content: 'summary_large_image' },
    { property: 'twitter:url', content: `${siteUrl}${route.fullPath}` },
    { property: 'twitter:title', content: t('menu.home') },
    { property: 'twitter:description', content: 'Home Page Description.' },
    { property: 'twitter:image', content: `${siteUrl}/static/images/project-logo.png` },
  ],
});

const features = [
  {
    title: 'pages.landing.docker.heading',
    description: 'pages.landing.docker.description',
    image: '/static/images/docker.png',
    isReverse: false,
  },
  {
    title: 'pages.landing.nuxt.heading',
    description: 'pages.landing.nuxt.description',
    image: '/static/images/nuxtjs.png',
    isReverse: true,
  },
  {
    title: 'pages.landing.laravel.heading',
    description: 'pages.landing.laravel.description',
    image: '/static/images/laravel.png',
    isReverse: false,
  },
];

const clients = [...Array(6)].map((_, index) => {
  index++;
  return {
    name: `Client ${index}`,
    logo: `/static/images/client-logo-${index}.png`,
  };
});

const reviews = [...Array(9)].map(() => ({
  avatar: faker.image.urlLoremFlickr({ category: 'people' }),
  name: `${faker.person.firstName()} ${faker.person.lastName()}`,
  comment: faker.lorem.words(15),
  rating: Math.random() * (5 - 1) + 1,
}));
</script>

<style scoped>
.text-white-shadow {
  font-weight: bold;
  color: white;
  text-shadow: 2px 2px rgba(0, 0, 0, 0.5);
}
</style>
