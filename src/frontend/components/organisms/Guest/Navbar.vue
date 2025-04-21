<template>
  <v-app-bar :elevation="0">
    <v-container>
      <div class="d-flex justify-space-between align-center">
        <div>
          <NuxtLink :to="localePath('/')">
            <img
              src="/static/images/project-icon.png"
              :alt="siteTitle"
              style="height: 48px"
            />
          </NuxtLink>
        </div>

        <div class="d-flex align-center ga-3">
          <MenuLinks />

          <LanguageSelect />

          <div class="d-none d-md-flex ga-3">
            <v-btn
              :to="localePath('/signup')"
              variant="outlined"
              nuxt
            >
              {{ $t('labels.signup') }}
            </v-btn>

            <v-btn
              :to="localePath('/login')"
              variant="flat"
              color="primary"
              nuxt
            >
              {{ $t('labels.login') }}
            </v-btn>
          </div>

          <MobileMenu />
        </div>
      </div>
    </v-container>
  </v-app-bar>
</template>

<script setup>
import MenuLinks from '~/components/molecules/MenuLinks.vue';
import MobileMenu from '~/components/molecules/MobileMenu.vue';
import LanguageSelect from '~/components/atoms/LanguageSelect.vue';
const localePath = useLocalePath();
const runtimeConfig = useRuntimeConfig();
const siteTitle = runtimeConfig.public.appName;
</script>
