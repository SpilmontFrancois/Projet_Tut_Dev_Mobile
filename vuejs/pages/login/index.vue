<template>
  <div class="bg-back">
    <div class="flex flex-col h-screen justify-between">
      <People class="w-full z-10" />
      <Ellipsis class="fixed top-1/4 w-full h-5/6" />
      <div class="fixed bg-purple h-3/6 w-full bottom-0" />
    </div>
  </div>
</template>

<script>
import People from '@/assets/svg/people.svg?inline'
import Ellipsis from '@/assets/svg/ellipse.svg?inline'

export default {
  name: 'LoginPage',
  components: {
    People,
    Ellipsis,
  },
  data() {
    return {
      email: null,
      password: null,
    }
  },
  methods: {
    login() {
      this.$auth.loginWith('laravelSanctum', {
        data: {
          email: this.email,
          password: this.password,
        },
      })
    },
  },
}
</script>