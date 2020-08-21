<template>
  <div>
    <b-navbar toggleable="sm" type="light" variant="primary">
      <b-navbar-brand href="#">
        <svg viewBox="0 0 24 24" width="24" height="24">
          <title>record vinyl</title>
          <path
            d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"
          ></path>
        </svg><a href="/" class="text-dark ml-2">Record Store</a>
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav v-if="$store.state.logedIn">
            <b-nav-item>
              <router-link to="/records" class="text-dark">Records</router-link>
            </b-nav-item>
            <b-nav-item>
              <router-link to="/artists" class="text-dark">Artists</router-link>
            </b-nav-item>
            <b-nav-item>
              <a href="#" @click.prevent="signOut" class="text-dark">Sign out</a>
            </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav v-else>
            <b-nav-item>
              <router-link to="/"  class="text-dark">Sign in</router-link>
            </b-nav-item>
            <b-nav-item>
              <router-link to="/signup" class="text-dark">Sign Up</router-link>
            </b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.isSignedIn()
  },
  methods: {
    setError (error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text
    },
    isSignedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured
        .delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.userID
          delete localStorage.signedIn
          this.$store.dispatch('setUserToLogout')
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
