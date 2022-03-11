<template>
  <div>
    <FeedCard
      v-for="(message, index) in messages"
      :key="index"
      :message="message" />
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
    }
  },
  mounted() {
    this.fetchMessages()
  },
  methods: {
    async fetchMessages() {
      const { data } = await this.axios.get('http://localhost:8000/api/posts')
      this.messages = data.data
    },
  },
}
</script>