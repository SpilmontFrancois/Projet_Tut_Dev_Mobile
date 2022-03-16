<template>
  <div class="card m-2">
    <div class="p-1 pb-2">
      <div>
        <img
          :src="message.user.avatar"
          class="rounded-full me-2 mb-1 h-10"
        />
        <small>
          {{ message.user.name }}
        </small>
      </div>
      <h5>{{ message.content }}</h5>
      <span class="flex justify-around mt-1">
        <div @click="star">
          <fa-icon :icon="['fas', 'star']" class="purple" />
          {{ stars }}
        </div>
        <div @click="share">
          <fa-icon :icon="['fas', 'retweet']" class="purple" />
          {{ shares }}
        </div>
        <div @click="showPost">
          <fa-icon :icon="['fas', 'comments']" class="purple" />
          {{ message.comments }}
        </div>
      </span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'FeedCardComponent',
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
        await this.$axios.post(
          `star/${this.message.id}`
        )
        this.stars++
      } catch (error) {
        console.log(error)
      }
    },
    async share() {
      try {
        await this.$axios.post(
          `share/${this.message.id}`
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