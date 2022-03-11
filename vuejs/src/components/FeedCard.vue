<template>
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">{{ message.content }}</h5>
      <span class="d-flex justify-content-around">
        <div><font-awesome-icon icon="star" /> {{ message.stars }}</div>
        <div><font-awesome-icon icon="retweet" /> {{ message.shares }}</div>
        <div><font-awesome-icon icon="comments" /> {{ message.comments }}</div>
      </span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    message: {
      type: Object,
      required: true,
    },
  },
}
</script>