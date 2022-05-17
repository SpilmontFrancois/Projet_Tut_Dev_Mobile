<template>
  <div class="bg-purple flex justify-around items-center h-14">
    <router-link class="m-0" to="">
      <fa-icon :icon="['fas', 'search']" color="white" />
    </router-link>
    <router-link class="m-0" to="/feed">
      <fa-icon :icon="['fas', 'home']" color="white" />
    </router-link>
    <router-link class="m-0" to="/profile">
      <fa-icon :icon="['fas', 'user-large']" color="white" />
    </router-link>
    <div class="m-0" @click="logout">
      <fa-icon :icon="['fas', 'sign-out-alt']" color="white" />
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