<template>
  <div class="pt-2">
    <div class="card mx-2 rounded-card p-3">
      <h1 class="text-xl"><strong>Profil</strong></h1>
      <div class="flex">
        <!-- Avatar -->
        <fa-icon
          v-if="!user.avatar"
          :icon="['fas', 'user']"
          class="text-dark-purple h-img m-4"
        />
        <img v-else :src="user.avatar" alt="Avatar" class="h-img m-4" />

        <!-- Informations du profil -->
        <div class="flex flex-col justify-center space-y-2">
          <div>
            <label for="username">Pseudo</label>
            <br />
            <input
              id="username"
              v-model="user.username"
              type="text"
              class="border rounded-lg p-1"
              :class="
                !editable
                  ? 'border-dark-purple text-dark-purple'
                  : 'border-purple text-purple'
              "
              :readonly="!editable"
            />
          </div>

          <div>
            <label for="lastname">Nom</label>
            <br />
            <input
              id="lastname"
              v-model="user.lastname"
              type="text"
              class="border rounded-lg p-1"
              :class="
                !editable
                  ? 'border-dark-purple text-dark-purple'
                  : 'border-purple text-purple'
              "
              :readonly="!editable"
            />
          </div>

          <div>
            <label for="firstname">Prénom</label>
            <br />
            <input
              id="firstname"
              v-model="user.firstname"
              type="text"
              class="border rounded-lg p-1"
              :class="
                !editable
                  ? 'border-dark-purple text-dark-purple'
                  : 'border-purple text-purple'
              "
              :readonly="!editable"
            />
          </div>

          <div>
            <label for="email">Email</label>
            <br />
            <input
              id="email"
              v-model="user.email"
              type="email"
              class="border rounded-lg p-1"
              :class="
                !editable
                  ? 'border-dark-purple text-dark-purple'
                  : 'border-purple text-purple'
              "
              :readonly="!editable"
            />
          </div>

          <div>
            <label for="bio">Biographie</label>
            <br />
            <input
              id="bio"
              v-model="user.bio"
              type="text"
              class="border rounded-lg p-1"
              :class="
                !editable
                  ? 'border-dark-purple text-dark-purple'
                  : 'border-purple text-purple'
              "
              :readonly="!editable"
            />
          </div>

          <div>
            <label for="avatar">Avatar</label>
            <br />
            <input
              id="avatar"
              v-model="user.avatar"
              type="text"
              class="border rounded-lg p-1"
              :class="
                !editable
                  ? 'border-dark-purple text-dark-purple'
                  : 'border-purple text-purple'
              "
              :readonly="!editable"
            />
          </div>
        </div>
      </div>
      <div class="flex justify-end mt-5">
        <button
          v-if="!editable"
          class="bg-dark-purple text-back rounded-full p-1 px-3"
          @click="editable = true"
        >
          Changer mes informations
        </button>
        <button
          v-else
          class="bg-dark-purple text-back rounded-full p-1 px-3"
          @click="updateUser"
        >
          Enregistrer
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProfilePage',
  data() {
    return {
      user: {},
      editable: false,
    }
  },
  created() {
    this.fetchUser()
  },
  methods: {
    async fetchUser() {
      const data = await this.$axios.$get('/api/me')
      this.user = data
    },
    async updateUser() {
      const { data } = await this.$axios.$put(
        `/api/users/${this.user.id}`,
        this.user
      )
      this.user = data
      this.editable = false
    },
  },
}
</script>