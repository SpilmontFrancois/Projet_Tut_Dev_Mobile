<template>
  <div v-if="loaded">
    <FeedCard
      v-for="(message, index) in messages"
      :key="index"
      :message="message" />
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
  components: {
    FeedCard,
  },
  data() {
    return {
      messages: [],
      loaded: false,
    }
  },
  mounted() {
    this.fetchMessages()
  },
  methods: {
    async fetchMessages() {
      const { data } = await this.axios.get('http://localhost:8000/api/posts')
      this.messages = data.data
      this.loaded = true
    },
  },
}
</script>