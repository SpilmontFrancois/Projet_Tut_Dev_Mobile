<template>
  <div class="card m-2">
    <div class="p-1 pb-2">
      <div class="flex justify-between">
        <div>
          <img :src="post.user.avatar" class="rounded-full me-2 mb-1 h-10" />
          <small>
            {{ post.user.name }}
          </small>
        </div>
        <div>
          <span>{{ date }}</span>
        </div>
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
        <div @click="showPost">
          <fa-icon :icon="['fas', 'comments']" class="purple" />
          {{ post.comments }}
        </div>
      </span>
    </div>
  </div>
</template>

<script>
import moment from '@/node_modules/moment'

export default {
  name: 'FeedCardComponent',
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
  computed: {
    date() {
      return moment(this.post.created_at).locale('fr').fromNow()
    },
  },
  created() {
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
    showPost() {
      this.$router.push(`/feed/${this.post.id}`)
    },
  },
}
</script>