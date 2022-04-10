<template>
  <div v-if="loaded">
    <FeedCard
      v-for="(post, index) in posts"
      :key="index"
      :post="post"
      @update="fetchMessages"
    />
  </div>
  <Spinner v-else />
</template>

<script>
export default {
  name: 'FeedComponent',
  data() {
    return {
      posts: [],
      loaded: false,
    }
  },
  mounted() {
    this.fetchMessages()
  },
  methods: {
    async fetchMessages() {
      const { data } = await this.$axios.$get('/api/posts')
      this.posts = data
      this.loaded = true
    },
  },
}
</script>