<template>
  <div>
    <div v-if="post">
      <PostCard :post="post" @update="$emit('update')" />
      <PostComments :comments="post.comments" />
      <PostNewComment
        v-if="showComment"
        @hide="$emit('hide')"
        @updateComment="$emit('updateComment')"
      />
    </div>
    <Spinner v-else />
  </div>
</template>

<script>
export default {
  name: 'PostComponent',
  props: {
    post: {
      type: Object,
      required: true,
    },
    showComment: {
      type: Boolean,
      required: true,
    },
  },
}
</script>