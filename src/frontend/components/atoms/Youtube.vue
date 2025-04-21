<template>
  <v-dialog width="720px">
    <template #activator="{ props: modalProps }">
      <div
        class="youtube-thumbnail"
        :style="`background-image: url(${thumbnail})`"
      >
        <div
          v-bind="modalProps"
          class="play-icon"
        >
          <v-icon
            icon="mdi-play"
            size="x-large"
          />
        </div>
      </div>
    </template>

    <template #default="{ isActive }">
      <v-btn
        variant="plain"
        density="compact"
        icon="mdi-close"
        @click="isActive.value = false"
      />

      <div class="youtube-player-container">
        <iframe
          :src="`https://www.youtube.com/embed/${videoId}?controls=0`"
          frame-border="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          class="youtube-player"
          allow-full-screen
        />
      </div>
    </template>
  </v-dialog>
</template>

<script setup>
const props = defineProps({
  videoId: {
    type: String,
    default: null,
  },
});

const thumbnail = `https://img.youtube.com/vi/${props.videoId}/maxresdefault.jpg`;
</script>

<style scoped>
.youtube-thumbnail {
  width: 100%;
  min-height: 315px;
  background-size: cover;
  background-position: center;
  display: flex;
  align-items: center;
  justify-content: center;
}
.play-icon {
  padding: 2px 16px;
  background: rgb(66, 66, 66);
  border-radius: 12px;
  cursor: pointer;
}
.play-icon:hover {
  background: rgb(177, 76, 80);
}
.youtube-player-container {
  position: relative;
  width: 100%;
  max-width: 1024px;
  padding-bottom: 56.25%;
  background-color: none;
}
.youtube-player {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
</style>
