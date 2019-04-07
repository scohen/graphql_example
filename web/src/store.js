import Vue from 'vue'
import Vuex from 'vuex'


const CURRENT_ENV_KEY = 'current-env'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    viewer: { id: -1, name: 'Please Login' },
  },

  mutations: {
    viewerChanged (state, viewer) {
      state.viewer = viewer
    },
  },

  actions: {},

  getters: {
    currentViewer (state) {
      return state.viewer
    },
  }

})
