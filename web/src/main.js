import '@/assets/custom.scss'
import '@/config/fontawesome'
import '@/config/global-components'

import Vue from 'vue'
import Buefy from 'buefy'

import App from './App.vue'
import router from './router'
import store from './store'

Vue.use(Buefy, {
  defaultIconPack: 'fas',
  defaultIconComponent: 'font-awesome-icon'
})

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
