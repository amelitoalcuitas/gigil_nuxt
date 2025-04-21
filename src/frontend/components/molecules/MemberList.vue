<template>
  <v-container>
    <v-row>
      <v-col
        v-for="(member, key) in members"
        :key="key"
        cols="12"
        sm="4"
      >
        <MemberCard
          :name="member.name"
          :avatar="member.avatar"
          :role="member.role"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import MemberCard from '~/components/atoms/MemberCard.vue';

defineProps({
  members: {
    type: Array,
    default: () => [],
  },
});
</script>
