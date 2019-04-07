<template>
  <div>
    <nav class="navbar">
      <div class="navbar-menu">
        <div class="navbar-brand">
          <div class="navbar-item">
            <span class="title has-text-white is-5 is-family-monospace">Graphql + Vue</span>
          </div>
        </div>
        <div class="navbar-menu">
          <div class="navbar-start">
            <a class="navbar-item">Other Stuff</a>
          </div>

          <div class="navbar-end">

            <div class="navbar-item has-dropdown is-hoverable is-right">
              <div class="navbar-link has-text-weight-bold">
                {{ currentViewer().name }}
              </div>
              <div class="navbar-dropdown">
                <router-link
                  :to="{ name: 'settings' }"
                  class="navbar-item"
                >
                  Settings
                </router-link>

                <router-link
                  :to="{ name: 'sign-out' }"
                  class="navbar-item"
                >
                  Sign out
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <div class="container is-fluid">
      <router-view :key="$route.fullPath" />
    </div>
  </div>
</template>
<script>
import { mapGetters, mapMutations } from 'vuex'
import { getActiveViewer } from '@/api/auth'

export default {
  metaInfo: {
    title: 'Main'
  },

  data () {
    return {
    }
  },

  async mounted () {
    const viewerResponse = await getActiveViewer()
    this.viewerChanged(viewerResponse)
  },

  methods: {
    ...mapGetters([
      'currentViewer',
    ]),

    ...mapMutations([
      'viewerChanged',
    ]),
  }
}
</script>
<style scoped>
 div.content {margin: 10px};
</style>
