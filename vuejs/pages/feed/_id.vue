<template>
  <div>
    <NavBar />
    <div v-if="loaded">
      <Post :post="post" />
    </div>
    <Spinner v-else />
  </div>
</template>

<script>
export default {
  data() {
    return {
      post: null,
      loaded: false,
    }
  },
  created() {
    this.fetchPost()
  },
  methods: {
    async fetchPost() {
      const { data } = await this.$axios.$get(
        `/api/posts/${this.$route.params.id}`
      )
      this.post = data
      this.fetchPostComments()
    },
    async fetchPostComments() {
      const { data } = await this.$axios.$get(
        `/api/post_comments/${this.$route.params.id}`
      )
      this.post.comments = data
      this.loaded = true
    },
  },
}
</script>