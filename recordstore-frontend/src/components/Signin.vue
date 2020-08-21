<template>
  <b-container>
    <b-row align-v="center" class="justify-content-md-center align-items-center mt-5 pt-5">
      <b-col align-self="center" md="4">
        <h2 class="mb-2 text-center">Sign in</h2>
        <b-form @submit.prevent="signin" class="justify-content-center">
          <div class="text-red" v-if="error">{{ error }}</div>

          <b-form-group class="form-group" label="Email:" label-for="email">
            <b-form-input type="email" required v-model="email" id="email" placeholder="example@example.com"></b-form-input>
          </b-form-group>

          <b-form-group class="form-group" label="Password:" label-for="password">
            <b-form-input type="password" required v-model="password" name="password" id="password"></b-form-input>
          </b-form-group>

          <b-button type="submit" variant="success">Sign in</b-button>
          <b-button variant="link" to="/signup">Sign up</b-button>
        </b-form>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccesful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccesful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.userID = response.data.id
      localStorage.signedIn = true
      this.$store.dispatch('setUserToLogin')
      this.error = ''
      this.$router.replace('/records')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
