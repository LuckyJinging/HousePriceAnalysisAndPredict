<template>
  <div style="float: left;text-align: left;margin-left: 20px">
    <p>房屋编号：{{msg['houseId']}}</p>
    <p>小区名称：{{msg['communityName']}}</p>
    <p>房屋大小：{{msg['houseSize']}}</p>
    <p>房屋总价：{{msg['housePrice']}}</p>
  </div>

</template>

<script>
import Vue from 'vue'
import axios from 'axios'
Vue.prototype.$axios = axios
export default {
  name: 'test',
  data () {
    return {
      msg: {}
    }
  },
  created () {
    axios.get('http://127.0.0.1:3000/tests/mytest').then(
      response => {
        console.log(response.data)
        this.msg = response.data
      }
    )
  }

}
</script>

<style scoped>

</style>
