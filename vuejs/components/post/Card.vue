<template>
  <div class="card m-2">
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
              ref="star"
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
              ref="share"
              :icon="['fas', 'retweet']"
              class="text-purple absolute"
            />
            <fa-icon :icon="['fas', 'retweet']" class="text-purple relative" />
          </div>
          {{ shares }}
        </div>
      </span>
    </div>
  </div>
</template>

<script>
import moment from '@/node_modules/moment'

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
      try {
        await this.$axios.$post(`/api/star/${this.post.id}`)
        this.$emit('update')
        this.$refs.star.classList.add('animate-ping')
        setTimeout(() => {
          this.$refs.star.classList.remove('animate-ping')
        }, 500)
      } catch (error) {
        console.log(error)
      }
    },
    async share() {
      try {
        await this.$axios.$post(`/api/share/${this.post.id}`)
        this.$emit('update')
        this.$refs.share.classList.add('animate-ping')
        setTimeout(() => {
          this.$refs.share.classList.remove('animate-ping')
        }, 500)
      } catch (error) {
        console.log(error)
      }
    },
  },
}
</script>