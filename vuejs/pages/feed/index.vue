<template>
  <div>
    <NavBar />
    <Feed />
  </div>
</template>

<script>
import NavBar from '../../components/NavBar.vue'
import Feed from '../../components/Feed.vue'

export default {
  name: 'FeedPage',
  components: {
    NavBar,
    Feed,
  },
}
</script>