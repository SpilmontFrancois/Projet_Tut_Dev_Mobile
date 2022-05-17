<template>
  <div>
    <div class="flex pt-2">
      <fa-icon
        :icon="['fas', 'angle-left']"
        size="2x"
        class="mx-5"
        @click="$router.push('/')"
      />
      <h1 class="text-3xl">Inscription</h1>
    </div>
    <div class="flex items-center justify-center">
      <div class="rounded-full bg-purple fixed h-540 w-screen-plus top-1/4">
        <div class="fixed z-50 bottom-1/4 left-0 w-full">
          <div class="flex flex-col items-center justify-center w-full">
            <div class="rounded-3xl h-10 w-5/6 bg-back">
              <input
                v-model="username"
                type="text"
                class="opacity-0 fixed cursor-text w-5/6 h-full"
                required
              />
              <span
                class="
                  border-b-2 border-gray
                  w-5/6
                  flex
                  justify-center
                  ml-7
                  mt-1
                  h-7
                "
              >
                {{ username }}
              </span>
            </div>
            <div class="rounded-3xl h-10 w-5/6 bg-back mt-4">
              <input
                v-model="firstname"
                type="text"
                class="opacity-0 fixed cursor-text w-5/6 h-full"
                required
              />
              <span
                class="
                  border-b-2 border-gray
                  w-5/6
                  flex
                  justify-center
                  ml-7
                  mt-1
                  h-7
                "
              >
                {{ firstname }}
              </span>
            </div>
            <div class="rounded-3xl h-10 w-5/6 bg-back mt-4">
              <input
                v-model="lastname"
                type="text"
                class="opacity-0 fixed cursor-text w-5/6 h-full"
                required
              />
              <span
                class="
                  border-b-2 border-gray
                  w-5/6
                  flex
                  justify-center
                  ml-7
                  mt-1
                  h-7
                "
              >
                {{ lastname }}
              </span>
            </div>
            <div class="rounded-3xl h-10 w-5/6 bg-back mt-4">
              <input
                v-model="email"
                type="email"
                class="opacity-0 fixed cursor-text w-5/6 h-full"
                required
              />
              <span
                class="
                  border-b-2 border-gray
                  w-5/6
                  flex
                  justify-center
                  ml-7
                  mt-1
                  h-7
                "
              >
                {{ email }}
              </span>
            </div>
            <div class="rounded-3xl h-10 w-5/6 bg-back mt-4">
              <input
                v-model="password"
                type="password"
                class="opacity-0 fixed cursor-text w-5/6 h-full"
                required
              />
              <div class="flex">
                <span
                  class="
                    border-b-2 border-gray
                    w-5/6
                    flex
                    justify-center
                    ml-7
                    mt-1
                    h-7
                  "
                >
                  {{ passwordVisible ? password : hiddenPassword }}
                </span>
                <fa-icon
                  class="z-50 mt-3"
                  :icon="
                    passwordVisible ? ['fas', 'eye-slash'] : ['fas', 'eye']
                  "
                  @click="passwordVisible = !passwordVisible"
                />
              </div>
            </div>
            <div class="rounded-3xl h-10 w-5/6 bg-back mt-4">
              <input
                v-model="password_confirmation"
                type="password"
                class="opacity-0 fixed cursor-text w-5/6 h-full"
                required
              />
              <div class="flex">
                <span
                  class="
                    border-b-2 border-gray
                    w-5/6
                    flex
                    justify-center
                    ml-7
                    mt-1
                    h-7
                  "
                >
                  {{
                    passwordConfirmVisible
                      ? password_confirmation
                      : hiddenPasswordConfirm
                  }}
                </span>
                <fa-icon
                  class="z-50 mt-3"
                  :icon="
                    passwordConfirmVisible
                      ? ['fas', 'eye-slash']
                      : ['fas', 'eye']
                  "
                  @click="passwordConfirmVisible = !passwordConfirmVisible"
                />
              </div>
            </div>
            <button
              class="rounded-3xl h-10 w-5/6 bg-dark-purple text-back mt-8 z-50"
              @click="register"
            >
              Créer mon compte
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RegisterPage',
  layout: 'auth',
  auth: 'guest',
  data() {
    return {
      username: "Nom d'utilisateur",
      firstname: 'Prénom',
      lastname: 'Nom',
      email: 'Email',
      password: 'Mot de passe',
      password_confirmation: 'Confirmation du mot de passe',
      passwordVisible: true,
      passwordConfirmVisible: true,
    }
  },
  computed: {
    hiddenPassword() {
      return '●'.repeat(this.password.length)
    },
    hiddenPasswordConfirm() {
      return '●'.repeat(this.password_confirmation.length)
    },
  },
  methods: {
    async register() {
      if (this.password !== this.password_confirmation) {
        return alert('Les mots de passe ne correspondent pas')
      }
      const token = await this.$axios.$post('/api/register', {
        username: this.username,
        firstname: this.firstname,
        lastname: this.lastname,
        email: this.email,
        password: this.password,
      })
      localStorage.setItem('token', token.access_token)
    },
  },
}
</script>