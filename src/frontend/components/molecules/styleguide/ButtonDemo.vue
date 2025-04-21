<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      class="mb-8"
      >Buttons</Heading
    >

    <BodyText>
      Usually, the default Vuetify button is used in pages and forms. However, there are cases where
      developer tends to override it causing inconsistensy on other pages.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="vuetifyButton"
      />
    </ClientOnly>

    <v-btn
      color="primary"
      class="my-4"
      >Submit</v-btn
    >

    <BodyText>
      Therefore, we will use our custom <strong>Button</strong> component with initial styling
      derived from the <strong>Button</strong> component of Vuetify with additional styling that
      will match our system needs. All the Button props from Vuetify are inherited by this custom
      component.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="buttonCode"
      />
    </ClientOnly>

    <v-row class="mt-4">
      <v-col
        v-for="variant in variants"
        :key="variant"
        cols="auto"
      >
        <Button :color="variant">{{ variant }}</Button>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';
import Button from '~/components/atoms/Button.vue';

const variants = ['primary', 'secondary', 'error', 'info', 'success', 'warning'];

const vuetifyButton = `<v-btn color="primary">Submit</v-btn>`;
const buttonCode = `import Button from '~/components/atoms/Button.vue';\n//const colors = ['primary','secondary','error','info','success','warning']; \n\n<Button color="primary">Submit</Button>`;
</script>
