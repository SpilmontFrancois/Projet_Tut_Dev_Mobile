<template>
  <div>
    <div v-if="loaded">
      <Post
        :post="post"
        :show-comment="showComment"
        @update="fetchPost"
        @updateComment="fetchPostComments"
        @hide="showComment = false"
      />
    </div>
    <Spinner v-else />
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
      @click="showComment = true"
    >
      <fa-icon :icon="['fas', 'pen']" class="text-2xl" color="white" />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      post: null,
      loaded: false,
      comments: null,
      showComment: false,
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