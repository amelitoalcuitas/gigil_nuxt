<script setup>
import { useTheme } from 'vuetify';

const theme = useTheme();
</script>

<template>
  <div :style="`background: ${theme.global.current?.value.colors.primary}`">
    <v-container>
      <div class="d-flex ga-8 text-white justify-center align-center w-full py-8">
        <h2>{{ $t('pages.landing.call_to_action') }}</h2>

        <v-btn
          variant="outlined"
          color="white"
          size="large"
          rounded="xl"
        >
          {{ $t('labels.get_started') }}
        </v-btn>
      </div>
    </v-container>
  </div>
</template>
