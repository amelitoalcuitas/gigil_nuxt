<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      class="mb-8"
      >Typography</Heading
    >

    <BodyText>
      The current global theme font-family is <strong>"Noto Sans JP", sans-serif</strong>. You can
      edit and change the values in <strong>src/frontend/layouts/default.vue</strong>
    </BodyText>

    <BodyText>
      We are using <strong>rem</strong> as unit of measurement. <strong>1 rem === 16px</strong>
    </BodyText>

    <Heading variant="h6">Heading Component</Heading>

    <BodyText>
      Vuetify has no dedicated component for headings so we can use this custom component to have
      uniform implementation.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="headingCode"
      />
    </ClientOnly>

    <Heading
      v-for="variant in headingVariants"
      :key="variant"
      :variant="variant"
    >
      This is a sample {{ variant }} heading.
    </Heading>

    <Heading
      variant="h6"
      class="mt-8"
      >Body Text</Heading
    >

    <BodyText>
      To have a uniform implementation for any body text, make use of the
      <strong>BodyText</strong> component. The <strong>BodyText</strong> component has a font-size
      of <strong>1 rem = 16px</strong>.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="normalBodyText"
      />
    </ClientOnly>

    <BodyText class="mt-4">
      If you want a text with smaller text, make use of the <strong>text-body-2</strong> variant.
      This variant has a font-size of <strong>14px</strong>.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="smallBodyText"
      />
    </ClientOnly>
  </v-container>
</template>

<script setup>
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';

const headingVariants = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'];
const headingCode = `import Heading from '~/components/atoms/Heading.vue';\n\n// const headingVariants = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'];\n<Heading variant="h1">This is a heading</Heading>`;
const normalBodyText = `import BodyText from '~/components/atoms/BodyText.vue';\n\n<BodyText>This is a a sample body text.</BodyText>`;
const smallBodyText = `import BodyText from '~/components/atoms/BodyText.vue';\n\n<BodyText variant="text-body-2">This is a a sample body text.</BodyText>`;
</script>
