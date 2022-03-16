<template>
  <div class="bg-nav flex justify-around items-center h-14">
    <router-link class="m-0" to="">
      <fa-icon :icon="['fas', 'search']" color="white" />
    </router-link>
    <router-link class="m-0" to="/feed">
      <fa-icon :icon="['fas', 'home']" color="white" />
    </router-link>
    <router-link class="m-0" to="/profile">
      <fa-icon :icon="['fas', 'user-large']" color="white" />
    </router-link>
    <router-link class="m-0" to="/messages">
      <fa-icon :icon="['fas', 'message']" color="white" />
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'NavBarComponent',
}
</script>