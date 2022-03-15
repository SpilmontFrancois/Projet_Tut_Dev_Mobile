<template>
  <div class="card m-2">
    <div class="card-body pb-2">
      <div class="card-text">
        <img
          :src="message.user.avatar"
          height="25"
          class="rounded-circle me-2 mb-1" />
        <span>
          {{ message.user.name }}
        </span>
      </div>
      <h5 class="card-title">{{ message.content }}</h5>
      <span class="d-flex justify-content-around">
        <div @click="star">
          <font-awesome-icon icon="star" class="svg-purple" />
          {{ stars }}
        </div>
        <div @click="share">
          <font-awesome-icon icon="retweet" class="svg-purple" />
          {{ shares }}
        </div>
        <div @click="showPost">
          <font-awesome-icon icon="comments" class="svg-purple" />
          {{ message.comments }}
        </div>
      </span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    message: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      stars: false,
      shares: false,
    }
  },
  created() {
    this.stars = this.message.stars
    this.shares = this.message.shares
  },
  methods: {
    async star() {
      try {
        await this.axios.post(
          `http://localhost:8000/api/star/${this.message.id}`
        )
        this.stars++
      } catch (error) {
        console.log(error)
      }
    },
    async share() {
      try {
        await this.axios.post(
          `http://localhost:8000/api/share/${this.message.id}`
        )
        this.shares++
      } catch (error) {
        console.log(error)
      }
    },
    showPost() {
      this.$router.push(`/feed/${this.message.id}`)
    },
  },
}
</script>