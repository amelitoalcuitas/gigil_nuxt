<template>
  <v-container
    class="py-16"
    fluid
  >
    <PageTitle
      :title="$t('pages.activate.heading')"
      :sub-title="$t('pages.activate.subtitle')"
    />

    <v-card
      class="pa-8 mx-auto mt-12"
      style="max-width: 420px"
    >
      <Form
        :validation-schema="schema"
        @submit="handleActivate"
      >
        <v-row>
          <v-col cols="12">
            <PasswordField
              :label="$t('labels.new_password')"
              name="password"
              type="password"
            />
          </v-col>

          <v-col cols="12">
            <PasswordField
              :label="$t('labels.confirm_new_password')"
              name="passwordConfirmation"
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
              {{ $t('labels.submit') }}
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
import PasswordField from '~/components/atoms/Form/PasswordField.vue';
import PageTitle from '~/components/atoms/PageTitle.vue';
import Button from '~/components/atoms/Button.vue';

const { t } = useI18n();
const { $api, $toast } = useNuxtApp();
const { query } = useRoute();
const { token } = query;
const submitting = ref(false);

useHead({
  title: t('menu.activate'),
});

// form validation
const schema = yup.object({
  password: yup
    .string()
    .required(t('form.required'))
    .min(8, t('form.password.minLength'))
    .matches(
      /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/,
      t('form.password.strong')
    ),
  passwordConfirmation: yup
    .string()
    .required(t('form.required'))
    .oneOf([yup.ref('password'), null], t('form.password.confirm')),
});

const handleActivate = async (data) => {
  submitting.value = true;

  /* eslint-disable camelcase */
  const { password, passwordConfirmation: password_confirmation } = data;

  return await $api
    .post('/activate', { token, password, password_confirmation })
    .then(async () => {
      await navigateTo('/login');
      $toast(t('pages.activate.activated'), { type: 'success' });
    })
    .catch((err) => {
      const {
        response: {
          data: { error },
        },
      } = err;
      $toast(error, { type: 'error' });
      submitting.value = false;
    });
};
</script>
