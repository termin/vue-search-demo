<template>
  <div id="app">
    <img src="./assets/logo.png">

    <section>
      <h1>
        Search
      </h1>
      <myFilter id="genre-filter" type="Genre" :root = "true" @change="changedFilter($event, 'selectedGenre')" />
      <myFilter id="artist-filter" type="Artist" :parent="selectedGenre" @change="changedFilter($event, 'selectedArtist')" />
      <myFilter id="album-filter" type="Album" :parent="selectedArtist" @change="filled" />
    </section>

    <section id="result">
      <h1>
        Result
      </h1>
      <ul class="tracks-container">
        <li v-for="(track, index) in tracks" :key="index">
          {{ track }}
        </li>
      </ul>
    </section>
  </div>
</template>

<script>
import myFilter from './Filter.vue'
import axios from 'axios'

export default {
  name: 'App',
  components: {
    myFilter,
  },
  data () {
    return {
      selectedGenre: "",
      selectedArtist: "",
      selectedAlbum: "",
      tracks: [],
    }
  },
  methods: {
    changedFilter: function(current, pos) {
      // console.log('changed(root)', current, pos)
      if (pos === 'selectedGenre') {
        this.selectedGenre = current
      }
      if (pos === 'selectedArtist') {
        this.selectedArtist = current
      }
    },
    filled: function(current) {
      this.selectedAlbum = current
      let v = this
      let url = `http://localhost:4567/tracks?genre=${this.selectedGenre}&artist=${this.selectedArtist}&album=${this.selectedAlbum}`

      axios.get(url)
      .then(function(response) {
        v.tracks = response.data
      })
      .catch(function(error) {
        console.log('getOptions', error)
      })
    }
  }
}
</script>

<style scoped>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  margin: 0 10px;
}
</style>
