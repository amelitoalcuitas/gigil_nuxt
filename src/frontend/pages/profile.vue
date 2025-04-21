<template>
  <v-container
    v-if="user"
    class="pt-6 pb-8"
    fluid
  >
    <PageTitle
      :title="$t('pages.profile.heading')"
      :sub-title="$t('pages.profile.sub_heading')"
    />

    <v-card
      class="pa-8 mx-auto mt-8"
      style="max-width: 400px"
    >
      <Form
        :validation-schema="schema"
        @submit="handleSubmit"
      >
        <v-row>
          <v-col cols="12">
            <AvatarField
              :label="user.full_name"
              :url="user.avatar"
              :editable="true"
              @on-file-select="handleFileSelect"
            />
            <Field
              v-model="avatar"
              name="avatar"
              type="hidden"
            />
          </v-col>

          <v-col
            cols="12"
            md="6"
          >
            <TextField
              v-model="firstName"
              :label="$t('labels.first_name')"
              name="first_name"
              type="text"
            />
          </v-col>

          <v-col
            cols="12"
            md="6"
          >
            <TextField
              v-model="lastName"
              :label="$t('labels.last_name')"
              name="last_name"
              type="text"
            />
          </v-col>

          <v-col cols="12">
            <TextField
              v-model="email"
              :label="$t('labels.email_address')"
              name="email"
              type="email"
            />
          </v-col>

          <v-col cols="12">
            <Button
              type="submit"
              block
            >
              {{ $t('labels.update') }}
            </Button>
          </v-col>
        </v-row>
      </Form>
    </v-card>
  </v-container>
</template>

<script setup>
import { ref } from 'vue';
import { Form, useForm, Field } from 'vee-validate';
import * as yup from 'yup';
import PageTitle from '~/components/atoms/PageTitle.vue';
import AvatarField from '~/components/atoms/AvatarField.vue';
import TextField from '~/components/atoms/Form/TextField.vue';
import Button from '~/components/atoms/Button.vue';

definePageMeta({
  middleware: ['auth'],
  layout: 'authenticated',
});

const { t } = useI18n();
const { $api, $toast } = useNuxtApp();
const store = useProfileStore();
const { user } = store;
const { defineField, setFieldValue } = useForm();
const [firstName] = defineField('first_name');
const [lastName] = defineField('last_name');
const [email] = defineField('email');
const avatar = ref(null);

useHead({
  title: t('menu.profile'),
});

if (user) {
  setFieldValue('first_name', user.first_name);
  setFieldValue('last_name', user.last_name);
  setFieldValue('email', user.email);
}

// form validation
const schema = yup.object({
  first_name: yup.string().required(t('form.required')),
  last_name: yup.string().required(t('form.required')),
  email: yup.string().required(t('form.required')).email(t('form.email')),
});

const handleSubmit = async (data) => {
  const formData = new FormData();
  formData.append('_method', 'PUT');

  // set fields
  for (const [key, value] of Object.entries(data)) {
    if (!value) continue;
    formData.append(key, value);
  }

  await $api
    .post('/profile', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    })
    .then(async ({ data }) => {
      await store.setProfile(data.data);
      $toast(t('pages.profile.success_message'), { type: 'success' });
    })
    .catch((err) => {
      const {
        response: {
          data: { message },
        },
      } = err;
      $toast(message, { type: 'error' });
    });
};

const handleFileSelect = (file) => (avatar.value = file);
</script>
