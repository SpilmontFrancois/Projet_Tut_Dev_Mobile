<template>
  <div class="center-component text-xl space-y-10 card p-10 rounded-card w-2/3">
    <h1 class="text-dark-purple flex justify-center">
      <strong>Erreur</strong>
    </h1>
    <div class="border-b border-gray" />
    <h1 v-if="error.statusCode === 404" class="flex justify-center">
      Page non trouvée
    </h1>
    <h1 v-else class="flex justify-center">Une erreur est survenue</h1>
    <NuxtLink
      :to="'/'"
      class="flex justify-center bg-dark-purple text-back rounded-full p-2"
    >
      Retour à l'accueil
    </NuxtLink>
  </div>
</template>

<script>
export default {
  name: 'ErrorLayout',
  layout: 'auth',
  props: {
    error: {
      type: Object,
      required: true,
    },
  },
}
</script>