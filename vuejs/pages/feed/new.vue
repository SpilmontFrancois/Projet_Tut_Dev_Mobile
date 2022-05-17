<template>
  <div class="py-2">
    <div class="card mx-2 rounded-card p-3 space-y-4">
      <h1 class="text-xl"><strong>Nouveau Post</strong></h1>
      <textarea
        ref="text"
        cols="20"
        rows="10"
        class="border border-dark-purple rounded-lg"
      />
      <div class="flex space-x-4 h-10">
        <button
          class="bg-dark-purple text-back rounded-full w-1/2"
          @click="$router.push('/feed')"
        >
          Annuler
        </button>
        <button class="bg-purple text-back rounded-full w-1/2" @click="post">
          Poster
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NewPostPage',
  methods: {
    async post() {
      const text = this.$refs.text.value
      if (text.length > 0) {
        await this.$axios.post('/api/posts', {
          content: text,
          user_id: this.$auth.user.id,
        })
        this.$router.push('/feed')
      }
    },
  },
}
</script>