import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Signin',
      props: true,
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      props: true,
      component: () => import(/* webpackChunkName: "Signup" */ '@/components/Signup')
    },
    {
      path: '/artists',
      name: 'Artists',
      props: true,
      component: () => import(/* webpackChunkName: "Artists" */ '@/components/artists/Artists')
    },
    {
      path: '/records',
      name: 'Records',
      props: true,
      component: () => import(/* webpackChunkName: "Records" */ '@/components/records/Records')
    }
  ]
})
