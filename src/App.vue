<template>
  <div id="app">
    <img src="./assets/logo.png">

    <section>
      <h1>
        Search
      </h1>
      <myFilter id="genre-filter" type="Genre" :root = "true" @change="changedFilter($event, 'selectedGenre')" />
      <myFilter id="artist-filter" type="Artist" :parent="selectedGenre" @change="changedFilter($event, 'selectedArtist')" />
      <myFilter id="album-filter" type="Album" :parent="selectedArtist" />
    </section>

    <section id="result">
      <h1>
        Result
      </h1>
    </section>
  </div>
</template>

<script>
import myFilter from './Filter.vue'

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

h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}

section {
  margin-bottom: 10px;
}
</style>
