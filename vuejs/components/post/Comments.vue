<template>
  <div>
    <div v-for="comment in comments" :key="comment.post_id" class="card m-2">
      <div class="p-1 pb-2">
        <div class="flex justify-between">
          <div>
            <img
              :src="comment.user.avatar"
              class="rounded-full me-2 mb-1 h-10"
            />
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
      required: true,
    },
  },
  methods: {
    date(dat) {
      return moment(dat).locale('fr').fromNow()
    },
  },
}
</script>