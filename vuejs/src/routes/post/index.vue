<template>
  <div>
    <NavBar />
    <div v-if="post" class="card m-2">
      <div class="card-body pb-2">
        <div class="card-text">
          <img
            :src="post.user.avatar"
            height="25"
            class="rounded-circle me-2 mb-1" />
          <span> {{ post.user.name }} </span>
        </div>
        <h5 class="card-title">{{ post.content }}</h5>
        <span class="d-flex justify-content-around">
          <div>
            <font-awesome-icon icon="star" class="svg-purple" />
            {{ post.stars }}
          </div>
          <div>
            <font-awesome-icon icon="retweet" class="svg-purple" />
            {{ post.shares }}
          </div>
        </span>
      </div>
    </div>
    <div>{{ comments }}</div>
  </div>
</template>

<script>
import NavBar from '../../components/NavBar.vue'

export default {
  components: {
    NavBar,
  },
  data() {
    return {
      comments: null,
      post: null,
    }
  },
  mounted() {
    this.fetchPost()
    this.fetchPostComments()
  },
  methods: {
    async fetchPost() {
      try {
        const { data } = await this.axios.get(
          `http://localhost:8000/api/posts/${this.$route.params.id}`
        )
        this.post = data.data
      } catch (error) {
        console.log(error)
      }
    },
    async fetchPostComments() {
      try {
        const { data } = await this.axios.get(
          `http://localhost:8000/api/post_comments/${this.$route.params.id}`
        )
        this.comments = data.data
      } catch (error) {
        console.log(error)
      }
    },
  },
}
</script>