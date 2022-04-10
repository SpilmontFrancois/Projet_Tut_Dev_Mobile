<template>
  <div class="mt-3">
    <span class="ml-2">Réponses</span>
    <div v-for="(comment, index) in comments" :key="index" class="card m-2">
      <div class="p-1 pb-2">
        <div class="flex justify-between">
          <div class="mb-1">
            <img :src="comment.user.avatar" class="rounded-full me-2 h-10" />
            <small>
              {{ comment.user.name }}
            </small>
          </div>
          <div>
            <span>{{ date(comment.created_at) }}</span>
          </div>
        </div>
        <h5 class="pl-4">{{ comment.content }}</h5>
      </div>
    </div>
  </div>
</template>

<script>
import moment from '@/node_modules/moment'

export default {
  name: 'PostCommentsComponent',
  props: {
    comments: {
      type: Array,
      nullable: true,
      default: () => [],
    },
  },
  methods: {
    date(dat) {
      return moment(dat).locale('fr').fromNow()
    },
  },
}
</script>