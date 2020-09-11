<template>
  <div>
    <b-jumbotron header="Records" lead="Add a new record" fluid>
      <b-form-row>
        <b-col sm="4">
          <b-form action="" @submit.prevent="addRecord">
            <b-form-input autofocus autocomplete="off" required v-model.trim="newRecord.title" placeholder="Type record title"></b-form-input>
            <b-form-input autocomplete="off" required v-model="newRecord.year" placeholder="Type a year record was released" class="mt-2" type="tel" v-mask="'####'"></b-form-input>
            <b-form-select required v-model="newRecord.artist" class="mt-2">
              <b-form-select-option disabled selected :value="null">Please select an artist</b-form-select-option>
              <b-form-select-option :value="artist.id" v-for="artist in artists" :key="artist.id">
                {{ artist.name }}
              </b-form-select-option>
            </b-form-select>
            <b-button type="submit" variant="success" class="mt-2">Add Record</b-button>
          </b-form>
          <p class="pt-4">Don't see an artist? <router-link to="/artists" class="link-grey">Create one</router-link></p>
        </b-col>
      </b-form-row>
      <div class="pt-2 text-danger" v-if="isError">{{ error }}</div>
    </b-jumbotron>

    <b-container class="mb-5">
      <b-list-group>
        <h2 class="text-center">List of records</h2>
        <b-list-group-item class="flex-column align-items-center" v-for="record in records" :key="record.id" :record="record">
          <div class="d-flex w-100 justify-content-between">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 24 24" width="24" height="24"><title>record vinyl</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" ></path></svg>
            {{ record.title }} &mdash; {{ record.year }}
            <h5 class="mb-1">{{ record.title }}</h5>
            <p class="block">{{ getArtist(record) }}</p>
            <div>
              <b-button variant="warning" @click.prevent="editRecord(record)">Edit</b-button>
              <b-button variant="danger" @click.prevent="removeRecord(record)">Delete</b-button>
            </div>
          </div>

          <div v-if="record == editedRecord">
            <b-form action="" @submit.prevent="updateRecord(record)" inline>
              <b-col>
                <b-form-input class="input" required v-model.trim="record.title" style="width: 200px;"></b-form-input>
                <b-form-input class="input" required v-model="record.year" style="width: 200px;" type="tel" v-mask="'####'"></b-form-input>
                <b-form-select id="artist_update" required v-model="record.artist">
                  <b-form-select-option :value="null">Select an artist</b-form-select-option>
                  <b-form-select-option :value="artist.id" v-for="artist in artists" :key="artist.id">
                    {{ artist.name }}
                  </b-form-select-option>
                </b-form-select>
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
import {mask} from 'vue-the-mask'

export default {
  name: 'Records',
  data () {
    return {
      artists: [],
      records: [],
      newRecord: {},
      error: '',
      editedRecord: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/records')
        .then(response => { this.records = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
      this.$http.secured.get('/api/v1/artists')
        .then(response => { this.artists = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  computed: {
    isError: function () {
      return this.error !== ''
    }
  },
  directives: {mask},
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    getArtist (record) {
      const recordArtistValues = this.artists.filter(artist => artist.id === record.artist_id)
      let artist
      recordArtistValues.forEach(function (element) {
        artist = element.name
      })
      return artist
    },
    addRecord () {
      const value = this.newRecord
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/records/', { record: { title: this.newRecord.title, year: this.newRecord.year, artist_id: this.newRecord.artist } })
        .then(response => {
          this.records.push(response.data)
          this.newRecord = {}
          this.error = ''
        })
        .catch(error => this.setError(error, 'Cannot create record'))
    },
    removeRecord (record) {
      this.$http.secured.delete(`/api/v1/records/${record.id}`)
        .then(response => {
          this.records.splice(this.records.indexOf(record), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete record'))
    },
    editRecord (record) {
      this.editedRecord = record
    },
    updateRecord (record) {
      this.editedRecord = ''
      this.$http.secured.patch(`/api/v1/records/${record.id}`, { record: { title: record.title, year: record.year, artist_id: record.artist.id } })
        .catch(error => this.setError(error, 'Cannot update record'))
    }
  }
}
</script>
