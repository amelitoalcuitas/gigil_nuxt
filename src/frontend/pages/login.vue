<template>
  <v-container
    class="py-16"
    fluid
  >
    <PageTitle :title="$t('labels.login')" />

    <v-card
      class="pa-8 mx-auto mt-12"
      style="max-width: 420px"
    >
      <Form
        :validation-schema="schema"
        @submit="handleLogin"
      >
        <v-row>
          <v-col cols="12">
            <TextField
              :label="$t('labels.email_address')"
              name="username"
              type="text"
            />
          </v-col>

          <v-col cols="12">
            <PasswordField
              :label="$t('labels.password')"
              name="password"
              type="password"
            />
          </v-col>

          <v-col cols="12">
            <Button
              type="submit"
              block
              :loading="submitting"
              :disabled="submitting"
            >
              {{ $t('labels.login') }}
            </Button>

            <Button
              :to="localePath('/password/forgot')"
              class="mt-4"
              variant="text"
              block
              nuxt
            >
              {{ $t('labels.forgot_password') }}
            </Button>
          </v-col>
        </v-row>
      </Form>
    </v-card>
  </v-container>
</template>

<script setup>
import { ref } from 'vue';
import { Form } from 'vee-validate';
import * as yup from 'yup';
import TextField from '~/components/atoms/Form/TextField.vue';
import PasswordField from '~/components/atoms/Form/PasswordField.vue';
import PageTitle from '~/components/atoms/PageTitle.vue';
import Button from '~/components/atoms/Button.vue';

const { t } = useI18n();
const { $config, $api, $toast } = useNuxtApp();
const { clientId, clientSecret } = $config.public;
const localePath = useLocalePath();
const submitting = ref(false);

useHead({
  title: t('menu.login'),
});

// form validation
const schema = yup.object({
  username: yup.string().required(t('form.required')).email(t('form.email')),
  password: yup.string().required(t('form.required')),
});

const handleLogin = async (data) => {
  const { username, password } = data;
  submitting.value = true;
  await $api
    .post('/oauth/token', {
      grant_type: 'password',
      client_id: clientId,
      client_secret: clientSecret,
      username,
      password,
    })
    .then(({ data }) => {
      const accessToken = useCookie('access_token');
      accessToken.value = data.access_token;
      const refreshToken = useCookie('refresh_token');
      refreshToken.value = data.refresh_token;
      // to reload cookie values
      window.location = localePath('/dashboard');
    })
    .catch((err) => {
      const {
        response: {
          data: { message },
        },
      } = err;
      $toast(message, { type: 'error' });
      submitting.value = false;
    });
};
</script>
