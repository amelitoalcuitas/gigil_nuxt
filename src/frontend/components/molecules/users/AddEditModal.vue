<template>
  <Modal
    v-model="model"
    :title="title"
  >
    <v-container class="p-8">
      <form @submit="handleFormSubmit">
        <v-row>
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
              type="text"
            />
          </v-col>

          <v-col
            cols="12"
            style="display: flex; justify-content: end; gap: 8px"
          >
            <Button
              variant="outlined"
              color="text"
              @click="emit('close')"
              >{{ $t('labels.cancel') }}</Button
            >
            <Button
              color="primary"
              type="submit"
              :loading="submitting"
              :disabled="submitting"
            >
              {{ user ? $t('labels.update') : $t('labels.save') }}
            </Button>
          </v-col>
        </v-row>
      </form>
    </v-container>
  </Modal>
</template>

<script setup>
import { ref, watch } from 'vue';
import { useForm } from 'vee-validate';
import * as yup from 'yup';
import TextField from '~/components/atoms/Form/TextField.vue';
import Modal from '~/components/organisms/Modal.vue';
import Button from '~/components/atoms/Button.vue';

const { $api, $toast, $errorHandler } = useNuxtApp();
const { t } = useI18n();
const submitting = ref(false);

const props = defineProps({
  user: {
    type: Object,
    default: null,
  },
  title: {
    type: String,
    default: null,
  },
});

const emit = defineEmits(['close', 'save']);

// form validation
const schema = yup.object({
  first_name: yup.string().required(t('form.required')),
  last_name: yup.string().required(t('form.required')),
  email: yup.string().required(t('form.required')).email(t('form.email')),
});
const { defineField, setFieldValue, handleSubmit, setFieldError } = useForm({
  validationSchema: schema,
});
const [firstName] = defineField('first_name');
const [lastName] = defineField('last_name');
const [email] = defineField('email');

const handleFormSubmit = handleSubmit(async (data, { resetForm }) => {
  submitting.value = true;
  try {
    const response = props.user
      ? await $api.put(`/users/${props.user.id}`, data).then(({ data }) => data.data)
      : await $api.post('/users', data).then(({ data }) => data.data);
    resetForm();
    emit('save', response);
    submitting.value = false;
  } catch (err) {
    $errorHandler(err, setFieldError, $toast);
    submitting.value = false;
  }
});

watch(props, () => {
  const { user } = props;
  if (user) {
    setFieldValue('first_name', user.first_name);
    setFieldValue('last_name', user.last_name);
    setFieldValue('email', user.email);
  }
});
</script>
