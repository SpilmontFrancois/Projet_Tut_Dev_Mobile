<template>
  <div class="card m-2">
    <div class="card-body pb-2">
      <h5 class="card-title">{{ message.content }}</h5>
      <div class="card-text">
        <img
          :src="message.user.avatar"
          height="25"
          class="rounded-circle me-2 mb-1" />
        <span>
          {{ message.user.name }}
        </span>
      </div>
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