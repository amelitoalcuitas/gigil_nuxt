<template>
  <div class="avatar-field-wrapper">
    <div
      class="avatar-field"
      :style="
        avatarUrl
          ? {
              'background-image': `url(${avatarUrl})`,
              'background-size': 'cover',
              'background-position': 'center center',
            }
          : { background: `${$stringToColor(label)}` }
      "
    >
      <span v-if="!avatarUrl">{{ getInitials(label?.split(' ')) }}</span>
    </div>

    <v-btn
      class="edit-icon"
      icon="mdi-pencil"
      size="x-small"
      @click="$refs.inputFile.click()"
    />

    <input
      ref="inputFile"
      type="file"
      name="avatar"
      accept="image/png, image/gif, image/jpeg"
      @change="selectAvatar"
    />
  </div>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
  label: {
    type: String,
    default: '',
  },
  url: {
    type: String,
    default: '',
  },
  editable: {
    type: Boolean,
    default: false,
  },
});

const avatarUrl = ref(null);
const { $stringToColor } = useNuxtApp();
const emit = defineEmits(['onFileSelect']);

// set user thumbnail if present
if (props.url) avatarUrl.value = props.url;

const selectAvatar = (e) => {
  let url = null;

  if (e.target.files.length > 0) {
    url = URL.createObjectURL(e.target.files[0]);
    avatarUrl.value = url;
    emit('onFileSelect', e.target.files[0]);
  }
};

const getInitials = (words) => {
  let initials = '';
  if (!words) return '';
  words.map((word) => (initials += word.substr(0, 1)));
  return initials;
};
</script>

<style scoped>
.avatar-field-wrapper {
  display: block;
  position: relative;
  width: 140px;
  height: 140px;
  margin: 0 auto 16px;
}

.avatar-field {
  width: 100%;
  height: 100%;
  display: flex;
  border-radius: 50%;
  padding: 4px;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 48px;
  overflow: none;
}

.edit-icon {
  position: absolute;
  bottom: -3px;
  right: 16px;
}

input[type='file'] {
  display: none;
}
</style>
