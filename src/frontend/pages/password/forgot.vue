<template>
  <v-container
    class="py-16"
    fluid
  >
    <PageTitle
      :title="$t('labels.forgot_password')"
      :sub-title="$t('pages.forgot_password.sub_heading')"
    />

    <v-card
      class="pa-8 mx-auto mt-12"
      style="max-width: 420px"
    >
      <Form
        :validation-schema="schema"
        @submit="handleForgot"
      >
        <v-row>
          <v-col cols="12">
            <TextField
              :label="$t('labels.email_address')"
              name="email"
              type="email"
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
import TextField from '~/components/atoms/Form/TextField.vue';
import PageTitle from '~/components/atoms/PageTitle.vue';
import Button from '~/components/atoms/Button.vue';

const { t } = useI18n();
const { $api, $toast } = useNuxtApp();
const submitting = ref(false);

useHead({
  title: t('menu.forgotPassword'),
});

// form validation
const schema = yup.object({
  email: yup.string().required(t('form.required')).email(t('form.email')),
});

const handleForgot = async (data) => {
  submitting.value = true;
  await $api
    .post('/password/forgot', data)
    .then(async () => {
      await navigateTo('/login');
      $toast(t('pages.forgot_password.success'), { type: 'success' });
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
