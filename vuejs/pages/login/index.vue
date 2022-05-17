<template>
  <div>
    <People />
    <div class="fixed z-50 bottom-1/6 w-full">
      <div class="flex flex-col items-center w-full">
        <div class="rounded-3xl h-10 w-5/6 bg-back">
          <input
            v-model="email"
            type="email"
            class="opacity-0 fixed cursor-text w-5/6 h-full"
            required
          />
          <span
            class="border-b-2 border-gray w-5/6 flex justify-center ml-7 mt-1"
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
              class="border-b-2 border-gray w-5/6 flex justify-center ml-7 mt-1"
            >
              {{ passwordVisible ? password : hiddenPassword }}
            </span>
            <fa-icon
              class="z-50 mt-3"
              :icon="passwordVisible ? ['fas', 'eye-slash'] : ['fas', 'eye']"
              @click="passwordVisible = !passwordVisible"
            />
          </div>
        </div>
        <button
          class="rounded-3xl h-10 w-5/6 bg-dark-purple text-back mt-4 z-50"
          @click="login"
        >
          Me connecter
        </button>
        <a href="#" class="text-back mt-4 z-50">
          <fa-icon class="z-50" :icon="['fas', 'lock']" />
          <span>Mot de passe oublié ?</span>
        </a>
        <NuxtLink
          to="/register"
          class="
            rounded-3xl
            h-10
            w-5/6
            bg-opacity-0
            text-back
            mt-4
            border-2
            fixed
            bottom-10
          "
        >
          <span class="flex items-center justify-center h-full">
            Me créer un compte
          </span>
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'LoginPage',
  layout: 'auth',
  data() {
    return {
      email: 'Adresse email',
      password: 'Mot de passe',
      passwordVisible: true,
    }
  },
  computed: {
    hiddenPassword() {
      return '●'.repeat(this.password.length)
    },
  },
  methods: {
    async login() {
      try {
        await this.$auth.loginWith('local', {
          data: { email: this.email, password: this.password },
        })
        this.$router.push('/feed')
      } catch (e) {
        console.log(e)
        this.$toast.error('Identifiants incorrects', {
          duration: 5000,
        })
      }
    },
  },
}
</script>