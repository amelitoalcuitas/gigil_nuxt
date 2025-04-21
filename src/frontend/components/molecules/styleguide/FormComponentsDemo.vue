<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      class="mb-8"
    >
      Form Components
    </Heading>

    <Heading variant="h6">TextField (Input Field)</Heading>

    <BodyText>
      Usually, the default Vuetify TextField is used in forms. However, there are cases where
      developer tends to override it causing inconsistency on other pages.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="vuetifyTextField"
        class="my-4"
      />
    </ClientOnly>

    <v-row>
      <v-col>
        <v-text-field label="Username"></v-text-field>
      </v-col>
      <v-col>
        <v-text-field
          label="Username"
          :value="username"
          hint="Field with validation errors"
          active
          error
          persistent-hint
        ></v-text-field>
      </v-col>
    </v-row>

    <BodyText class="mt-4">
      Therefore, we will use our custom TextField component with initial styling derived from the
      <strong>TextField</strong> component of Vuetify with additional styling that will match our
      system needs. All the TextField props from Vuetify are inherited by this custom component.
    </BodyText>

    <v-row>
      <v-col>
        <TextField label="Username" />
      </v-col>
      <v-col>
        <TextField
          v-model="username"
          label="Username"
          hint="Field with validation errors"
        />
      </v-col>
    </v-row>

    <v-divider class="my-8"></v-divider>

    <Heading
      variant="h6"
      class="my-4"
      >TextArea</Heading
    >
    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="textAreaCode"
        class="my-4"
      />
    </ClientOnly>

    <TextArea
      label="Description"
      :value="description"
    />

    <v-divider class="my-8"></v-divider>

    <Heading
      variant="h6"
      class="my-4"
      >File Select</Heading
    >
    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="fileInputCode"
        class="my-4"
      />
    </ClientOnly>

    <FileInput label="Attachment" />

    <v-divider class="my-8"></v-divider>

    <Heading
      variant="h6"
      class="my-4"
      >Checkboxes</Heading
    >

    <BodyText>
      Use our custom Checkbox component with initial styling derived from the
      <strong>Checkbox</strong> component of Vuetify with additional styling that will match our
      system needs. All the Checkbox props from Vuetify are inherited by this custom component.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="checkboxCode"
        class="my-4"
      />
    </ClientOnly>

    <v-row>
      <v-col
        v-for="color in colors"
        :key="color"
        cols="12"
        md="4"
      >
        <Checkbox
          :label="`Checkbox color ${color}`"
          :color="color"
        />
      </v-col>
    </v-row>

    <v-divider class="my-8"></v-divider>

    <Heading
      variant="h6"
      class="my-4"
      >Select</Heading
    >

    <BodyText>
      Use our custom Select component with initial styling derived from the
      <strong>Select</strong> component of Vuetify with additional styling that will match our
      system needs. All the Select props from Vuetify are inherited by this custom component.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="selectCode"
        class="my-4"
      />
    </ClientOnly>

    <Select
      label="Gender"
      :options="genderList"
    />

    <v-divider class="my-8"></v-divider>

    <Heading
      variant="h6"
      class="my-4"
      >Radio Button</Heading
    >

    <BodyText>
      Use our custom RadioGroup component with initial styling derived from the
      <strong>RadioGroup</strong> component of Vuetify with additional styling that will match our
      system needs. All the RadioGroup props from Vuetify are inherited by this custom component.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="radioGroupCode"
        class="my-4"
      />
    </ClientOnly>

    <RadioGroup
      label="Gender"
      :options="genderList"
    />

    <BodyText>
      If you want the options to be inline, just specify <strong>:inline="true"</strong>
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="radioGroupCodeInline"
        class="my-4"
      />
    </ClientOnly>

    <RadioGroup
      label="Gender"
      :options="genderList"
      :inline="true"
    />

    <v-divider class="my-8"></v-divider>

    <Heading variant="h6">DatePicker</Heading>

    <BodyText>
      To make use of the custom <strong>DatePicker</strong> component, you will need to pass the
      <strong>label</strong> props. You can pass the date <strong>format</strong> props as optional.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="datePickeCode"
        class="my-4"
      />
    </ClientOnly>

    <DatePicker label="Birthday" />
  </v-container>
</template>

<script setup>
import { faker } from '@faker-js/faker';
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';
import TextField from '~/components/atoms/Form/TextField.vue';
import TextArea from '~/components/atoms/Form/TextArea.vue';
import Checkbox from '~/components/atoms/Form/Checkbox.vue';
import FileInput from '~/components/atoms/Form/FileInput.vue';
import Select from '~/components/atoms/Form/Select.vue';
import RadioGroup from '~/components/atoms/Form/RadioGroup.vue';
import DatePicker from '~/components/atoms/Form/DatePicker.vue';

const username = 'admin@site.com';
const description = faker.lorem.paragraphs(4);
const colors = ['primary', 'secondary', 'error', 'info', 'success', 'warning'];
const genderList = [
  { label: 'Male', value: 'Male' },
  { label: 'Female', value: 'Female' },
];
const vuetifyTextField = `<v-text-field label="Username"></v-text-field>`;
const textAreaCode = `import TextArea from '~/components/atoms/Form/TextArea.vue';\n\n<TextArea label="Description" />`;
const fileInputCode = `import FileInput from '~/components/atoms/Form/FileInput.vue';\n\n<FileInput label="Attachment" />`;
const checkboxCode = `import Checkbox from '~/components/atoms/Form/Checkbox.vue';\n\n<Checkbox label="My Checkbox Label" color="primary" />`;
const selectCode = `import Select from '~/components/atoms/Form/Select.vue';
const genderList = [
  { label: 'Male', value: 'Male' },
  { label: 'Female', value: 'Female' },
];

<Select label="Gender" :options="genderList" />
`;
const radioGroupCode = `import RadioGroup from '~/components/atoms/Form/RadioGroup.vue';
const genderList = [
  { label: 'Male', value: 'Male' },
  { label: 'Female', value: 'Female' },
];

<RadioGroup label="Gender" :options="genderList" />
`;
const radioGroupCodeInline = `import RadioGroup from '~/components/atoms/Form/RadioGroup.vue';
const genderList = [
  { label: 'Male', value: 'Male' },
  { label: 'Female', value: 'Female' },
];

<RadioGroup label="Gender" :options="genderList" :inline="true" />
`;

const datePickeCode = `import DatePicker from '~/components/atoms/Form/DatePicker.vue';\n\n<DatePicker label="Birthday" />`;
</script>
