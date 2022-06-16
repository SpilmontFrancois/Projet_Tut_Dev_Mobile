<template>
  <div class="bg-purple flex justify-around items-center h-14">
    <NuxtLink class="m-0" to="/feed">
      <fa-icon :icon="['fas', 'home']" color="white" class="w-5 h-5" />
    </NuxtLink>
    <NuxtLink class="m-0" to="/profile">
      <fa-icon :icon="['fas', 'user-large']" color="white" class="w-5 h-5" />
    </NuxtLink>
    <div class="m-0" @click="logout">
      <fa-icon :icon="['fas', 'sign-out-alt']" color="white" class="w-5 h-5" />
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