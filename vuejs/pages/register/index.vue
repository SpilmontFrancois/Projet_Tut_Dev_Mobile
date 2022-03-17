<template>
  <div>
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">Inscription</h4>
        <form @submit.prevent="register">
          <div class="form-group">
            <label for="username">Username</label>
            <input
              type="text"
              class="form-control"
              id="username"
              v-model="username"
            />
          </div>
          <div class="form-group">
            <label for="firstname">Prénom</label>
            <input
              type="text"
              class="form-control"
              id="firstname"
              v-model="firstname"
            />
          </div>
          <div class="form-group">
            <label for="lastname">Nom</label>
            <input
              type="text"
              class="form-control"
              id="lastname"
              v-model="lastname"
            />
          </div>
          <div class="form-group">
            <label for="email">Email</label>
            <input
              type="email"
              class="form-control"
              id="email"
              v-model="email"
            />
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input
              type="password"
              class="form-control"
              id="password"
              v-model="password"
            />
          </div>
          <div class="form-group">
            <label for="password_confirmation">Password Confirmation</label>
            <input
              type="password"
              class="form-control"
              id="password_confirmation"
              v-model="password_confirmation"
            />
          </div>
          <button type="submit" class="btn btn-primary">Register</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RegisterPage',
  auth: 'guest',
  data() {
    return {
      username: '',
      firstname: '',
      lastname: '',
      email: '',
      password: '',
      password_confirmation: '',
    }
  },
  methods: {
    async register() {
      if (this.password !== this.password_confirmation) {
        return alert('Les mots de passe ne correspondent pas')
      }
      const token = await this.axios.post(
        '/api/register',
        {
          username: this.username,
          firstname: this.firstname,
          lastname: this.lastname,
          email: this.email,
          password: this.password,
        }
      )
      localStorage.setItem('token', token.data.access_token)
      this.$cookies.set('token', token.data.access_token)
      console.log(this.$cookies.get('token'))
    },
  },
}
</script>