<template>
  <div>
    <div v-if="loaded">
      <Post :post="post" @update="fetchPost" />
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
      comments: null,
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
      if (!this.comments) this.fetchPostComments()
      else this.post.comments = this.comments
    },
    async fetchPostComments() {
      const { data } = await this.$axios.$get(
        `/api/post_comments/${this.$route.params.id}`
      )
      this.post.comments = data
      this.comments = data
      this.loaded = true
    },
  },
}
</script>