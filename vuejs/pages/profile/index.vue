<template>
  <div>
    <NavBar />
    <div class="card m-4 rounded-card p-3">
      <h2>Profil</h2>
      <div class="flex">
        <fa-icon :icon="['fas', 'user']" class="text-dark-purple h-img m-4" />
        <div class="flex flex-col justify-center">
          <p class="m-0">{{ user.lastname }}</p>
          <p class="m-0">{{ user.firstname }}</p>
          <p class="m-0">{{ user.email }}</p>
        </div>
      </div>
      <div class="flex justify-end mt-5">
        <button class="bg-dark-purple text-back rounded-full p-1 px-3">
          Changer de mot de passe
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import NavBar from '../../components/NavBar.vue'

export default {
  name: 'ProfilePage',
  components: {
    NavBar,
  },
  data() {
    return {
      user: {},
    }
  },
  created() {
    this.fetchUser()
  },
  methods: {
    async fetchUser() {
      // TODO : change user id to current user id
      const { data } = await this.$axios.get('/api/users/1')
      this.user = data.data
    },
  },
}
</script>