<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      >Accordion</Heading
    >

    <BodyText>
      We will use our custom Accordion component with initial styling derived from the
      <strong>Accordion</strong> component of Vuetify with additional styling that will match our
      system needs. You will just pass an array <strong>items</strong> with
      <strong>header and content</strong> properties.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="code"
        class="my-8"
      />
    </ClientOnly>

    <Accordion :items="questions" />
  </v-container>
</template>

<script setup>
import { faker } from '@faker-js/faker';
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';
import Accordion from '~/components/molecules/Accordion.vue';

const questions = [...Array(5)].map(() => ({
  header: `${faker.lorem.words(5)}?`,
  content: faker.lorem.paragraphs(2, '\n'),
}));

const code = `import Accordion from 'components/molecules/Accordion';
const items = [
  { header: 'This is the Header 1', content: 'This is some content 1.'},
  { header: 'This is the Header 2', content: 'This is some content 2.'},
];


<Accordion :items="items">
`;
</script>
