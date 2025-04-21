<template>
  <v-container class="mt-8">
    <PageTitle
      :title="$t('pages.inquiry.heading')"
      :sub-title="$t('pages.inquiry.sub_heading')"
    />

    <v-card
      class="mt-8 mb-16 pa-6 mx-auto"
      style="max-width: 400px"
    >
      <Form
        :validation-schema="schema"
        @submit="handleSubmit"
      >
        <v-row>
          <v-col cols="12">
            <TextField
              name="fullname"
              type="text"
              :label="$t('labels.fullname')"
            />
          </v-col>

          <v-col cols="12">
            <TextField
              name="email"
              type="email"
              :label="$t('labels.email_address')"
            />
          </v-col>

          <v-col cols="12">
            <TextArea
              name="content"
              :label="$t('labels.inquiry_content')"
            />
          </v-col>

          <v-col cols="12">
            <Button
              type="submit"
              block
              >{{ $t('labels.submit') }}</Button
            >
          </v-col>
        </v-row>
      </Form>
    </v-card>
  </v-container>
</template>

<script setup>
import { Form } from 'vee-validate';
import * as yup from 'yup';
import PageTitle from '~/components/atoms/PageTitle.vue';
import Button from '~/components/atoms/Button.vue';
import TextField from '~/components/atoms/Form/TextField.vue';
import TextArea from '~/components/atoms/Form/TextArea.vue';

const { t } = useI18n();
const { $api, $toast } = useNuxtApp();

useHead({
  title: t('menu.inquiry'),
});

const schema = yup.object({
  fullname: yup.string().required(t('form.required')),
  email: yup.string().required(t('form.required')).email(t('form.email')),
  content: yup.string().required(t('form.required')),
});

const handleSubmit = async (data, { resetForm }) => {
  await $api
    .post('/inquiries', data)
    .then(() => {
      $toast(t('pages.inquiry.success_message'), { type: 'success' });
      resetForm();
    })
    .catch(() => {
      $toast(t('pages.inquiry.failed_message'), { type: 'error' });
    });
};
</script>
