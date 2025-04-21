<template>
  <v-container fluid>
    <Heading
      variant="h4"
      align="center"
      class="mb-8"
    >
      Modal
    </Heading>

    <BodyText>
      Use our custom <strong>Modal</strong> component with initial styling derived from the
      <strong>Modal</strong> component of <strong>Vuetify</strong> with additional styling that will
      match our system needs.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="modalCode"
        class="mb-4"
      ></highlightjs>
    </ClientOnly>

    <Button @click="open = true">Open Modal</Button>

    <Modal
      v-model="open"
      title="My Custom Modal"
    >
      <div class="pa-4">Here goes the Modal Content</div>
    </Modal>

    <v-divider class="my-8"></v-divider>

    <BodyText>
      If you want to a side-modal, you can make use of our custom <strong>Drawer</strong> component.
      This inherits the Vuetify <strong>Drawer</strong>
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="drawerCode"
        class="mb-4"
      ></highlightjs>
    </ClientOnly>

    <Button @click="openDrawer = true">Open Drawer</Button>

    <Drawer
      v-model="openDrawer"
      title="My Custom Drawer"
    >
      <div class="pa-4">Here goes the Drawer Content</div>
    </Drawer>
  </v-container>
</template>

<script setup>
import { ref } from 'vue';
import Modal from '~/components/organisms/Modal.vue';
import Drawer from '~/components/organisms/Drawer.vue';
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';
import Button from '~/components/atoms/Button.vue';

const open = ref(false);
const openDrawer = ref(false);

const modalCode = `
import Modal from '~/components/organisms/Modal.vue';
import { ref } from 'vue';
const open = ref(false);

<button @click="open = true">Open Modal</button>

<Modal v-model="open" title="My Custom Modal">
  <div class="pa-4">Here goes the Modal Content</div>
</Modal>
`;

const drawerCode = `
import Drawer from '~/components/organisms/Drawer.vue';
import { ref } from 'vue';
const open = ref(false);

<button @click="open = true">Open Drawer</button>

<Drawer v-model="open" title="My Custom Drawer">
  <div class="pa-4">Here goes the Drawer Content</div>
</Drawer>
`;
</script>
