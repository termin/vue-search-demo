<template>
  <div class="filter">
    <el-select
      v-if="root"
      v-model="value"
      clearable
      :placeholder="'Select ' + type"
      @change="change">
      <el-option
        v-for="item in options"
        :key="item"
        :label="item"
        :value="item" c/>
    </el-select>

    <el-select
      v-else
      v-model="value"
      clearable
      filterable
      :disabled="disabled"
      :placeholder="'Select ' + type"
      @change="change">
      <el-option
        v-for="item in options"
        :key="item"
        :label="item"
        :value="item" />
    </el-select>
  </div>
</template>

<script>
import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(ElementUI)
import axios from 'axios'

export default {
  name: 'MyFilter',
  props: {
    type: {
      type: String,
      default: "",
    },
    root: {
      type: Boolean,
      default: false,
      required: false,
    },
    parent: {
      type: String,
      default: "",
      required: false, // rootは不要
    },
  },
  data () {
    return {
      value: '',
      options: [],
      disabled: true,
    }
  },
  watch: {
    parent: function(n, o) {
      console.log('watched variable parent:', n, o, this.type)
      if (this.type === 'Genre') return

      this.disabled = (n == '') // 親が指定されていなければ操作不能
      this.value = ''
      this.setOptions()
    },
    value: function(n) {
      this.$emit('change', n)
    }
  },
  created: function() {
    if (this.type === 'Genre') {
      this.disabled = false
      this.options = [
        'Classical',
        'Jazz',
      ]
    } else {
      this.options = ['empty']
    }
  },
  methods: {
    // change: function(current) {
    //   this.$emit('change', current)
    // },
    setOptions: function() {
      var v = this
      let urls = {
        'Artist': 'http://localhost:4567/artists?genre=',
        'Album': 'http://localhost:4567/albums?artist=',
      }

      axios.get(urls[this.type] + this.parent)
      .then(function(response) {
        console.log('getOptions response', response.data)
        let d = response.data
        console.log('response', d)
        v.options = d
      })
      .catch(function(error) {
        console.log('getOptions', error)
      })
    },
  },
}
</script>

<style scoped>
.filter {
  display: inline-block;
}
</style>
