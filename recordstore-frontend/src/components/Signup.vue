<template>
  <b-container>
    <b-row align-v="center" class="justify-content-md-center align-items-center mt-5 pt-5">
      <b-col align-self="center" md="4">
        <h2 class="mb-2 text-center">Sign up</h2>
        <b-form @submit.prevent="signup" class="justify-content-center">
          <div class="text-red" v-if="error">{{ error }}</div>

          <b-form-group class="form-group" label="Email:" label-for="email">
            <b-form-input type="email" required v-model="email" id="email" placeholder="example@example.com"></b-form-input>
          </b-form-group>

          <b-form-group class="form-group" label="Password:" label-for="password">
            <b-form-input type="password" required v-model="password" name="password" id="password"></b-form-input>
          </b-form-group>

          <b-form-group class="form-group" label="Password confirmation:" label-for="password_confirmation">
            <b-form-input type="password" required v-model="password_confirmation" name="password" id="password_confirmation"></b-form-input>
          </b-form-group>

          <b-button type="submit" variant="success">Sign up</b-button>
          <b-button variant="link" to="/">Sign in</b-button>
        </b-form>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccesful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccesful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.userID = response.data.id
      localStorage.signedIn = true
      this.$store.dispatch('setUserToLogin')
      this.error = ''
      this.$router.replace('/records')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Email is already taken.'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
