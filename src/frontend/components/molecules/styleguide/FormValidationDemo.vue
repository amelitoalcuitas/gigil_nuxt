<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      class="mb-8"
    >
      Form Validation
    </Heading>

    <BodyText>
      Our Base Template uses
      <NuxtLink
        to="https://vee-validate.logaretm.com/v4/"
        target="_blank"
      >
        VeeValidate
      </NuxtLink>
      together with
      <NuxtLink
        to="https://github.com/jquense/yup#getting-started"
        target="_blank"
      >
        Yup Schema Validation
      </NuxtLink>
      for Form Data validation.
    </BodyText>

    <BodyText>
      Below is a sample Form Validation demo utilizing our custom Components. You can check the
      source code in
      <strong>frontend/src/components/molecules/styleguide/FormValidationDemo.js</strong>
    </BodyText>

    <form @submit="handleFormSubmit">
      <v-row>
        <v-col
          cols="12"
          md="6"
          ><TextField
            v-model="firstName"
            label="First Name"
            name="first_name"
        /></v-col>
        <v-col
          cols="12"
          md="6"
          ><TextField
            v-model="lastName"
            label="Last Name"
            name="last_name"
        /></v-col>
        <v-col
          cols="12"
          md="6"
          ><TextField
            v-model="email"
            label="Email"
            name="email"
        /></v-col>
        <v-col
          cols="12"
          md="6"
          ><Select
            v-model="gender"
            label="Gender"
            name="gender"
            placeholder="Pleas select"
            :options="genders"
        /></v-col>
        <v-col cols="12">
          <DatePicker
            v-model="birthday"
            label="Birthday"
            name="birthday"
          />
        </v-col>
        <v-col cols="12">
          <TextArea
            v-model="description"
            label="Description"
            name="description"
          />
        </v-col>
        <v-col cols="12">
          <FileInput
            v-model="attachment"
            label="Attachment"
            name="attachment"
          />
        </v-col>
        <v-col cols="12">
          <RadioGroup
            v-model="subscribe"
            label="Subscribe to Newsletter"
            name="subscribe"
            :options="options"
            :inline="true"
          />
        </v-col>
        <v-col cols="12">
          <Checkbox
            v-model="acceptTerms"
            label="I agree to the Terms and Conditions"
            name="acceptTerms"
          />
        </v-col>
        <v-col
          cols="12"
          class="d-flex justify-end"
        >
          <Button type="submit">Submit</Button>
        </v-col>
      </v-row>
    </form>
  </v-container>
</template>

<script setup>
import { useForm } from 'vee-validate';
import * as yup from 'yup';
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';
import Button from '~/components/atoms/Button.vue';
import TextField from '~/components/atoms/Form/TextField.vue';
import TextArea from '~/components/atoms/Form/TextArea.vue';
import Checkbox from '~/components/atoms/Form/Checkbox.vue';
import FileInput from '~/components/atoms/Form/FileInput.vue';
import Select from '~/components/atoms/Form/Select.vue';
import RadioGroup from '~/components/atoms/Form/RadioGroup.vue';
import DatePicker from '~/components/atoms/Form/DatePicker.vue';

const { t } = useI18n();

const genders = [
  { label: 'Male', value: 'Male' },
  { label: 'Female', value: 'Female' },
  { label: 'Other', value: 'Other' },
];

const options = [
  { label: 'Yes', value: 'Yes' },
  { label: 'No', value: 'No' },
];

// form validation
const schema = yup.object({
  first_name: yup.string().required(t('form.required')),
  last_name: yup.string().required(t('form.required')),
  email: yup.string().required(t('form.required')).email(t('form.email')),
  description: yup.string().required(t('form.required')),
  gender: yup.string().required(t('form.required')),
  subscribe: yup.string().required(t('form.required')),
  acceptTerms: yup.bool().oneOf([true], t('form.required')),
  attachment: yup
    .mixed()
    .test('required', t('form.required'), (value) => {
      return value && value.length;
    })
    .test('fileSize', 'The file is too large.', (value) => {
      return value && value[0] && value[0].size <= 1000000;
    })
    .test('type', 'Only Images are allowed.', function (value) {
      return value && value[0] && ['image/jpeg', 'image/png', 'image/gif'].includes(value[0].type);
    }),
  birthday: yup.date().required(t('form.required')).typeError('Please select a valid date'),
});

const { defineField, handleSubmit } = useForm({
  initialValues: {
    acceptTerms: false,
    birthday: null,
    attachment: null,
  },
  validationSchema: schema,
});
const [firstName] = defineField('first_name');
const [lastName] = defineField('last_name');
const [email] = defineField('email');
const [gender] = defineField('gender');
const [birthday] = defineField('birthday');
const [description] = defineField('description');
const [acceptTerms] = defineField('acceptTerms');
const [subscribe] = defineField('subscribe');
const [attachment] = defineField('attachment');

const handleFormSubmit = handleSubmit((data) => alert(JSON.stringify(data, null, 4)));
</script>
