<template>
  <div class="d-flex justify-space-around">
    <v-btn
      variant="text"
      append-icon="mdi-menu-down"
      class="px-0"
    >
      <CountryFlag
        :country="selectedLocale"
        size="small"
      />

      <v-menu activator="parent">
        <ClientOnly>
          <v-list>
            <v-list-item
              v-for="(item, index) in locales"
              :key="index"
              :to="switchLocalePath(item === 'us' ? 'en' : 'ja')"
              align="center"
              link
            >
              <CountryFlag
                :country="item"
                size="small"
              />
            </v-list-item>
          </v-list>
        </ClientOnly>
      </v-menu>
    </v-btn>
  </div>
</template>

<script setup>
import CountryFlag from 'vue-country-flag-next';
import { ref, watch } from 'vue';
const switchLocalePath = useSwitchLocalePath();

const locales = ['us', 'jp'];
const { locale } = useI18n();
// initial value
const selectedLocale = ref(locale.value === 'en' ? 'us' : 'jp');

watch(locale, (newLocale) => {
  selectedLocale.value = newLocale === 'en' ? 'us' : 'jp';
});
</script>
