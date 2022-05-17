<template>
  <div>
    <Feed />
    <div
      class="
        fixed
        right-5
        bottom-5
        bg-dark-purple
        rounded-full
        h-16
        w-16
        flex
        items-center
        justify-center
      "
      @click="$router.push('/feed/new')"
    >
      <fa-icon :icon="['fas', 'pen']" class="text-2xl" color="white" />
    </div>
  </div>
</template>

<script>
export default {
  name: 'FeedPage',
}
</script>