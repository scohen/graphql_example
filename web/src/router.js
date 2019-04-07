import Vue from 'vue'
import Router from 'vue-router'


import Settings from '@/views/settings.vue'
import SignIn from '@/views/sign-in.vue'
import Welcome from '@/views/welcome.vue'
import MainLayout from '@/components/main-layout.vue'

import { getActiveViewer, signOut } from '@/api/auth'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'sign-in',
      component: SignIn,
      meta: {
        signedInRedirect: 'welcome'
      }
    },
    {
      path: "/welcome",
      component: MainLayout,
      children: [
        {
          path: '',
          component: Welcome,
          name: 'welcome'
        }

      ]
    },
    {
      path: '/signout',
      name: 'sign-out',
      meta: {
        signOut: true
      }
    },
    {
      path: '/account',
      component: MainLayout,
      meta: {
        signedOutRedirect: 'sign-in'
      },
      children: [
        {
          path: 'settings',
          name: 'settings',
          component: Settings
        }
      ]
    },
  ]
})

router.beforeEach(async (to, from, next) => {
  const viewer = await getActiveViewer()
  for (let { meta } of to.matched) {
    if (meta.signedOutRedirect && !viewer) {
      next({ name: meta.signedOutRedirect })
      return
    } else if (meta.signedInRedirect && viewer) {
      next({ name: meta.signedInRedirect })
      return
    } else if (meta.signOut) {
      await signOut()
      // never returns
    }
  }
  next()
})

export default router
