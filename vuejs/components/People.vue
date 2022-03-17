<template>
  <div class="flex flex-col h-screen justify-between">
    <People class="w-full z-10" />
    <Ellipsis class="fixed top-1/4 w-full h-5/6 z-0" />
    <div class="fixed bg-purple h-3/6 w-full bottom-0 z-0" />
  </div>
</template>

<script>
import People from '@/assets/svg/people.svg?inline'
import Ellipsis from '@/assets/svg/ellipse.svg?inline'

export default {
  name: 'PeopleComponent',
  components: {
    People,
    Ellipsis,
  },
}
</script>