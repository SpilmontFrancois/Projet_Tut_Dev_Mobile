<template>
  <div>
    <NavBar />
    <div v-if="loaded">
      <PostCard :post="post" />
    </div>
    <div v-else>
      <div class="d-flex justify-content-center mt-2">
        <div class="spinner-border" role="status" />
      </div>
    </div>
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
      this.loaded = true
    },
  },
}
</script>