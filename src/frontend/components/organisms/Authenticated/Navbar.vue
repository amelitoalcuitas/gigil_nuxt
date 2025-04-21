<template>
  <v-app-bar color="primary">
    <v-app-bar-nav-icon
      :icon="open ? 'mdi-arrow-left' : 'mdi-menu'"
      variant="text"
      @click.stop="emit('toggleSidebar')"
    ></v-app-bar-nav-icon>

    <v-spacer></v-spacer>

    <LanguageSelect />

    <ClientOnly>
      <div
        v-if="user"
        class="mx-4"
      >
        <v-menu :close-on-content-click="false">
          <template #activator="{ props }">
            <v-avatar
              v-bind="props"
              :image="user?.avatar"
              size="36"
              :color="$stringToColor(user.full_name)"
              style="cursor: pointer"
            >
              <span class="text-h5">{{ getInitials(user.full_name) }}</span>
            </v-avatar>
          </template>

          <v-card
            min-width="250"
            class="mt-4"
          >
            <v-list>
              <v-list-item
                :to="localePath('/profile')"
                class="text-body-2"
                link
              >
                {{ $t('menu.profile') }}
              </v-list-item>
              <v-list-item
                class="text-body-2"
                style="cursor: pointer"
                @click="handleLogout"
              >
                {{ $t('menu.logout') }}
              </v-list-item>
            </v-list>
          </v-card>
        </v-menu>
      </div>
    </ClientOnly>
  </v-app-bar>
</template>

<script setup>
import LanguageSelect from '~/components/atoms/LanguageSelect.vue';

defineProps({
  open: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits(['toggleSidebar']);
const { $api, $stringToColor } = useNuxtApp();
const accessToken = useCookie('access_token');
const refreshToken = useCookie('refresh_token');
const { user } = useProfileStore();
const localePath = useLocalePath();

const handleLogout = async () => {
  await $api.delete('/oauth/token').then(() => {
    accessToken.value = null;
    refreshToken.value = null;
  });

  await navigateTo(localePath('/login?ref=logout'));
};

const getInitials = (string) => {
  return `${string.split(' ')[0][0]}${string.split(' ')[1][0]}`;
};
</script>
