<template>
  <div class="card mx-2">
    <div class="p-1 pb-2">
      <div class="flex justify-between">
        <div class="mb-1">
          <img :src="post.user.avatar" class="rounded-full me-2 h-10" />
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
        <div class="flex items-center" @click="star">
          <div class="flex mr-1">
            <fa-icon
              :ref="'star' + post.id"
              :icon="['fas', 'star']"
              class="text-purple absolute"
            />
            <fa-icon :icon="['fas', 'star']" class="text-purple relative" />
          </div>
          {{ stars }}
        </div>
        <div class="flex items-center" @click="share">
          <div class="flex mr-1">
            <fa-icon
              :ref="'share' + post.id"
              :icon="['fas', 'retweet']"
              class="text-purple absolute"
            />
            <fa-icon :icon="['fas', 'retweet']" class="text-purple relative" />
          </div>
          {{ shares }}
        </div>
        <div @click="showPost">
          <fa-icon :icon="['fas', 'comments']" class="text-purple" />
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
      stars: null,
      shares: null,
    }
  },
  computed: {
    date() {
      return moment(this.post.created_at).locale('fr').fromNow()
    },
  },
  watch: {
    post(newVal, oldVal) {
      if (oldVal.stars !== newVal.stars) {
        this.stars = newVal.stars
      }
      if (oldVal.shares !== newVal.shares) {
        this.shares = newVal.shares
      }
    },
  },
  mounted() {
    this.stars = this.post.stars
    this.shares = this.post.shares
  },
  methods: {
    async star() {
      await this.$axios.$post(`/api/star/${this.post.id}`)
      this.$emit('update')
      this.$refs[`star${this.post.id}`].classList.add('animate-ping')
      setTimeout(() => {
        this.$refs[`star${this.post.id}`].classList.remove('animate-ping')
      }, 500)
    },
    async share() {
      await this.$axios.$post(`/api/share/${this.post.id}`)
      this.$emit('update')
      this.$refs[`share${this.post.id}`].classList.add('animate-ping')
      setTimeout(() => {
        this.$refs[`share${this.post.id}`].classList.remove('animate-ping')
      }, 500)
    },
    showPost() {
      this.$router.push(`/feed/${this.post.id}`)
    },
  },
}
</script>