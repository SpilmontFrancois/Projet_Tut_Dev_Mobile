<template>
  <div>
    <NavBar />
    <div class="card m-4 rounded-card p-3">
      <h2>Profil</h2>
      <div class="d-flex">
        <font-awesome-icon icon="user" class="svg-dark-purple h-img m-4" />
        <div class="d-flex flex-column justify-content-center">
          <p class="m-0">{{ user.lastname }}</p>
          <p class="m-0">{{ user.firstname }}</p>
          <p class="m-0">{{ user.email }}</p>
        </div>
      </div>
      <div class="d-flex justify-content-end mt-5">
        <button class="btn btn-dark-purple rounded-pill w-75">
          Changer de mot de passe
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import NavBar from '../../components/NavBar.vue'

export default {
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
      const { data } = await this.axios.get('http://localhost:8000/api/users/1')
      this.user = data.data
    },
  },
}
</script>