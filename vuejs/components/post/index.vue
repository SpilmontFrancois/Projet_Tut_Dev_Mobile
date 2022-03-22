<template>
  <div>
    <PostCard :post="post" />
    <PostComments :comments="post.comments" />
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