<template>
  <div class="bg-purple flex justify-around items-center h-14">
    <NuxtLink to="/feed">
      <fa-icon :icon="['fas', 'house']" color="white" class="w-5 h-5" />
    </NuxtLink>
    <NuxtLink to="/profile">
      <fa-icon :icon="['fas', 'user-large']" color="white" class="w-5 h-5" />
    </NuxtLink>
    <div @click="logout">
      <fa-icon
        :icon="['fas', 'right-from-bracket']"
        color="white"
        class="w-5 h-5"
      />
    </div>
  </div>
</template>

<script>
export default {
  name: 'NavBarComponent',
  methods: {
    logout() {
      this.$auth.logout()
      this.$router.push('/')
    },
  },
}
</script>