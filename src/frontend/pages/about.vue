<template>
  <v-container
    class="py-16 px-0"
    fluid
  >
    <PageTitle
      :title="$t('pages.about.main_heading')"
      :sub-title="$t('pages.about.sub_heading')"
    />

    <HeroImage
      :image="faker.image.urlLoremFlickr({ category: 'technics' })"
      height="300px"
    />

    <section>
      <v-container
        class="py-16"
        align="center"
      >
        <h5 class="text-h5 mb-2 font-weight-bold">
          {{ $t('pages.about.meet_the_team') }}
        </h5>

        <BodyText variant="text-body-2">
          {{ $t('pages.about.team_description') }}
        </BodyText>

        <ClientOnly>
          <MemberList :members="members" />
        </ClientOnly>
      </v-container>
    </section>

    <section style="background: white">
      <v-container class="py-16">
        <v-row>
          <v-col
            cols="12"
            md="6"
          >
            <div class="d-flex flex-column justify-center h-100">
              <h3 class="mb-4">{{ $t('pages.about.our_mission') }}</h3>
              <BodyText variant="text-body-2">
                {{ $t('pages.about.mission_description') }}
              </BodyText>
            </div>
          </v-col>

          <v-col
            cols="12"
            md="6"
          >
            <Youtube video-id="mocuGRf2UVg" />
          </v-col>
        </v-row>
      </v-container>
    </section>

    <section>
      <v-container
        class="py-16"
        align="center"
      >
        <h5 class="text-h5 mb-2 font-weight-bold">
          {{ $t('pages.about.our_activities') }}
        </h5>

        <BodyText variant="text-body-2">
          {{ $t('pages.about.activities_description') }}
        </BodyText>

        <div class="mt-8">
          <QuiltedImageList :images="images" />
        </div>
      </v-container>
    </section>
  </v-container>
</template>

<script setup>
import { faker } from '@faker-js/faker';
import BodyText from '~/components/atoms/BodyText.vue';
import PageTitle from '~/components/atoms/PageTitle.vue';
import HeroImage from '~/components/atoms/HeroImage.vue';
import Youtube from '~/components/atoms/Youtube.vue';
import MemberList from '~/components/molecules/MemberList.vue';
import QuiltedImageList from '~/components/molecules/QuiltedImageList.vue';

const { t } = useI18n();

useHead({
  title: t('menu.about'),
});

const members = [...Array(6)].map(() => ({
  name: `${faker.person.firstName()} ${faker.person.lastName()}`,
  avatar: faker.image.urlLoremFlickr({ category: 'people' }),
  role: faker.person.jobTitle(),
}));

const images = [
  { cols: 4, url: faker.image.urlLoremFlickr({ category: 'city' }) },
  { cols: 4, url: faker.image.urlLoremFlickr({ category: 'city' }) },
  { cols: 4, url: faker.image.urlLoremFlickr({ category: 'city' }) },
  {
    cols: 8,
    children: [
      { cols: 12, url: faker.image.urlLoremFlickr({ category: 'city' }) },
      { cols: 12, url: faker.image.urlLoremFlickr({ category: 'city' }) },
    ],
  },
  { cols: 6, url: faker.image.urlLoremFlickr({ category: 'city' }) },
  { cols: 3, url: faker.image.urlLoremFlickr({ category: 'city' }) },
  { cols: 9, url: faker.image.urlLoremFlickr({ category: 'city' }) },
  { cols: 4, url: faker.image.urlLoremFlickr({ category: 'city' }) },
  { cols: 8, url: faker.image.urlLoremFlickr({ category: 'city' }) },
];
</script>
