import Vuex from 'vuex'
import Vue from 'vue'

Vue.use(Vuex)

export default new Vuex.Store({
  state: { // data
    logedIn: false
  },

  getters: { // computed properties
    isUserLogedIn (state) {
      return state.logedIn
    }
  },

  actions: { // methods
    setUserToLogin ({state, commit}) {
      if (!state.logedIn) {
        commit('setLoginStatus', true)
      }
    },
    setUserToLogout ({state, commit}) {
      if (state.logedIn) {
        commit('setLoginStatus', false)
      }
    }
  },

  mutations: { // set and update state
    setLoginStatus (state, value) {
      state.logedIn = value
    }
  }
})
