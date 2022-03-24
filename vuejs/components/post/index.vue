<template>
  <div>
    <div v-if="post">
      <PostCard :post="post" />
      <PostComments :comments="post.comments" />
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
  },
}
</script>