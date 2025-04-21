<template>
  <v-row>
    <template
      v-for="(image, key) in images"
      :key="key"
    >
      <QuiltedImageListItem
        :cols="image.cols"
        :url="image.url"
      />

      <v-col
        v-if="image.children"
        cols="6"
        class="d-flex flex-column"
      >
        <v-row>
          <template
            v-for="(img, index) in image.children"
            :key="index"
          >
            <QuiltedImageListItem
              :cols="img.cols"
              :url="img.url"
            />
          </template>
        </v-row>
      </v-col>
    </template>
  </v-row>
</template>

<script setup>
import QuiltedImageListItem from '~/components/atoms/QuiltedImageListItem.vue';

defineProps({
  images: {
    type: Array,
    default: () => [],
  },
});
</script>
