<template>
  <div v-if="loaded">
    <FeedCard
      v-for="(post, index) in posts"
      :key="index"
      :post="post" />
  </div>
  <div v-else>
    <div class="d-flex justify-content-center mt-2">
      <div class="spinner-border" role="status" />
    </div>
  </div>
</template>

<script>
import FeedCard from './FeedCard.vue'

export default {
  name: 'FeedComponent',
  components: {
    FeedCard,
  },
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