<template>
  <div>
    <b-jumbotron header="Artists" lead="Add new artist" fluid>
      <b-form-row>
        <b-col>
          <b-form action="" @submit.prevent="addArtist" inline>
            <b-form-input autofocus autocomplete="off" v-model="newArtist.name" placeholder="Type an arist name" style="width: 200px;"></b-form-input>
            <b-button type="submit" variant="success" class="ml-2">Add Artist</b-button>
          </b-form>
        </b-col>
      </b-form-row>
      <div class="pt-2 text-danger" v-if="error">{{ error }}</div>
    </b-jumbotron>

    <b-container class="mb-5">
      <b-list-group>
        <h2 class="text-center">List of artists</h2>
        <b-list-group-item class="flex-column align-items-center" v-for="artist in artists" :key="artist.id" :artist="artist">
          <div class="d-flex w-100 justify-content-between">
            <h5 class="mb-1">{{ artist.name }}</h5>
            <div>
              <b-button variant="warning" @click.prevent="editArtist(artist)">Edit</b-button>
              <b-button variant="danger" @click.prevent="removeArtist(artist)">Delete</b-button>
            </div>
          </div>

          <div v-if="artist == editedArtist">
            <b-form action="" @submit.prevent="updateArtist(artist)" inline>
              <b-col>
                  <b-form-input class="input" v-model="artist.name" style="width: 200px;"></b-form-input>
                  <b-button type="submit" value="Update" variant="success">Update</b-button>
              </b-col>
            </b-form>
          </div>
        </b-list-group-item>
      </b-list-group>
    </b-container>
  </div>
</template>

<script>
export default {
  name: 'Artists',
  data () {
    return {
      artists: [],
      newArtist: {},
      error: '',
      editedArtist: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/artists')
        .then(response => { this.artists = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addArtist () {
      const value = this.newArtist
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/artists/', { artist: { name: this.newArtist.name, user_id: parseInt(localStorage.getItem('userID')) } })
        .then(response => {
          this.artists.push(response.data)
          this.newArtist = {}
        })
        .catch(error => this.setError(error, 'Cannot create artist'))
    },
    removeArtist (artist) {
      this.$http.secured.delete(`/api/v1/artists/${artist.id}`)
        .then(response => {
          this.artists.splice(this.artists.indexOf(artist), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete artist'))
    },
    editArtist (artist) {
      this.editedArtist = artist
    },
    updateArtist (artist) {
      this.editedArtist = ''
      this.$http.secured.patch(`/api/v1/artists/${artist.id}`, { artist: { name: artist.name } })
        .catch(error => this.setError(error, 'Cannot update artist'))
    }
  }
}
</script>
