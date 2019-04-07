import Vue from 'vue'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { library } from '@fortawesome/fontawesome-svg-core'

// explicitly import the icons we use and add them to the library
import { faEnvelope, faEye, faLock } from '@fortawesome/free-solid-svg-icons'

library.add(faEnvelope, faEye, faLock)

Vue.component('font-awesome-icon', FontAwesomeIcon)

export { FontAwesomeIcon }
