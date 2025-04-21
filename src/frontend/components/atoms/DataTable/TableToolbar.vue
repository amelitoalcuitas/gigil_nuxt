<template>
  <div class="d-flex flex-column flex-sm-row justify-space-between pt-4 ga-4 mb-4">
    <div class="search-box">
      <v-text-field
        v-model="keyword"
        :placeholder="$t('labels.enter_keyword')"
        :append-inner-icon="submitted ? 'mdi-close' : 'mdi-magnify'"
        density="compact"
        variant="solo"
        hide-details
        @click:append-inner="handleSearch"
      ></v-text-field>
    </div>

    <Button
      class="add-new"
      prepend-icon="mdi-plus"
      color="primary"
      @click="emit('add')"
    >
      {{ $t('labels.add_new') }}
    </Button>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import Button from '~/components/atoms/Button.vue';

const keyword = ref(null);
const submitted = ref(false);
const emit = defineEmits(['search', 'add']);

const handleSearch = () => {
  if (submitted.value) {
    keyword.value = '';
    submitted.value = false;
  } else {
    if (!keyword.value || keyword.value?.length < 1) return;
    submitted.value = true;
  }
  emit('search', keyword.value);
};
</script>

<style scoped>
.search-box {
  display: flex;
  width: 100%;
  max-width: 300px;
}
</style>
