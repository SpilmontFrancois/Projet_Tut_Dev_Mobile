<template>
  <div class="card m-2 p-4">
    <h1 class="mb-1"><strong>Nouveau commentaire</strong></h1>
    <input
      v-model="content"
      type="text"
      class="border border-dark-purple rounded-lg p-2"
    />
    <div class="flex justify-between space-x-4 p-2">
      <button
        class="bg-dark-purple text-back rounded-full w-1/2 p-1"
        @click="$emit('hide')"
      >
        Annuler
      </button>
      <button
        class="bg-purple text-back rounded-full w-1/2 p-1"
        @click="comment"
      >
        Commenter
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NewComment',
  data() {
    return {
      content: '',
    }
  },
  methods: {
    async comment() {
      const { data } = await this.$axios.$post('/api/post_comments', {
        user_id: this.$auth.user.id,
        post_id: this.$route.params.id,
        content: this.content,
      })
      this.$emit('updateComment', data)
      this.$emit('hide')
    },
  },
}
</script>