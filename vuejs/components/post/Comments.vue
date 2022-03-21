<template>
  <div>{{ comments }}</div>
</template>

<script>
export default {
  name: 'PostCommentsComponent',
  props: {
    comments: {
      type: Object,
      required: true,
    },
  },
}
</script>