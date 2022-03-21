<template>
  <div class="card m-2">
    <div class="p-1 pb-2">
      <div>
        <img :src="post.user.avatar" class="rounded-full me-2 mb-1 h-10" />
        <small>
          {{ post.user.name }}
        </small>
      </div>
      <h5>{{ post.content }}</h5>
      <span class="flex justify-around mt-1">
        <div @click="star">
          <fa-icon :icon="['fas', 'star']" class="purple" />
          {{ stars }}
        </div>
        <div @click="share">
          <fa-icon :icon="['fas', 'retweet']" class="purple" />
          {{ shares }}
        </div>
      </span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PostCardComponent',
  props: {
    post: {
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
  mounted() {
    this.stars = this.post.stars
    this.shares = this.post.shares
  },
  methods: {
    async star() {
      try {
        await this.$axios.$post(`/api/star/${this.post.id}`)
        this.stars++
      } catch (error) {
        console.log(error)
      }
    },
    async share() {
      try {
        await this.$axios.$post(`/api/share/${this.post.id}`)
        this.shares++
      } catch (error) {
        console.log(error)
      }
    },
  },
}
</script>