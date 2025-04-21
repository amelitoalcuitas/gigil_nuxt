<template>
  <v-container
    class="py-16"
    fluid
  >
    <PageTitle :title="$t('pages.signup.create_free_account')" />

    <v-card
      class="pa-8 mx-auto mt-16"
      style="max-width: 420px"
    >
      <form @submit="handleSignup">
        <v-row>
          <v-col
            cols="12"
            sm="6"
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
            sm="6"
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
              type="text"
            />
          </v-col>

          <v-col cols="12">
            <Checkbox name="accept_terms">
              <template #label>
                <p>
                  {{ $t('pages.signup.agree_to_terms') }}
                  <NuxtLink
                    to="/terms"
                    target="_blank"
                  >
                    {{ $t('pages.signup.terms_conditions') }}
                  </NuxtLink>
                </p>
              </template>
            </Checkbox>
          </v-col>

          <v-col cols="12">
            <Button
              type="submit"
              block
              :loading="submitting"
              :disabled="submitting"
            >
              {{ $t('labels.signup') }}
            </Button>
          </v-col>
        </v-row>
      </form>
    </v-card>
  </v-container>
</template>

<script setup>
import { ref } from 'vue';
import { useForm } from 'vee-validate';
import * as yup from 'yup';
import TextField from '~/components/atoms/Form/TextField.vue';
import PageTitle from '~/components/atoms/PageTitle.vue';
import Button from '~/components/atoms/Button.vue';
import Checkbox from '~/components/atoms/Form/Checkbox.vue';

const { t } = useI18n();
const { $api, $toast, $errorHandler } = useNuxtApp();
const submitting = ref(false);

useHead({
  title: t('menu.createAccount'),
});

// form validation
const schema = yup.object({
  first_name: yup.string().required(t('form.required')),
  last_name: yup.string().required(t('form.required')),
  email: yup.string().required(t('form.required')).email(t('form.email')),
  accept_terms: yup.bool().oneOf([true], t('form.required')),
});

const { defineField, handleSubmit, setFieldError } = useForm({
  validationSchema: schema,
});
const [firstName] = defineField('first_name');
const [lastName] = defineField('last_name');
const [email] = defineField('email');

const handleSignup = handleSubmit(async (data, { resetForm }) => {
  submitting.value = true;
  await $api
    .post('/register', data)
    .then(() => {
      $toast(t('pages.signup.signup_complete'), { type: 'success' });
      resetForm();
      submitting.value = false;
    })
    .catch((err) => {
      $errorHandler(err, setFieldError, $toast);
      submitting.value = false;
    });
});
</script>
