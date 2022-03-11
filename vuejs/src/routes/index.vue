<template>
  <router-view />
</template>

<script>
export default {
  mounted() {
    this.$router.push('/feed')
  },
}
</script>