<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import echarts from 'echarts'
import axios from 'axios'
require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'

export default {
  mixins: [resize],
  props: {
    className: {
      type: String,
      default: 'chart'
    },
    width: {
      type: String,
      default: '100%'
    },
    height: {
      type: String,
      default: '320px'
    }
  },
  data() {
    return {
      chart: null
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.initData()
    })
  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    initData(){
      let nameList = []
      let valueList = []
      let dataMerge = []
      let j=0
      axios.get('http://127.0.0.1:3000/houseinfo/houseType').then((response) => {
        // console.log(response.data)
        this.msg = response.data
        for (let i in response.data) {
          // console.log(i)
          // console.log(response.data[i])
          nameList[j] = response.data[i].housetype
          valueList[j] = parseInt(response.data[i].num )
          dataMerge.push({ value: valueList[j], name: nameList[j] })
          j+=1
          if (j === 6)
            break
        }
        // console.log(nameList)
        // console.log(dataMerge)
        this.initChart(nameList,dataMerge)
      })
    },
    initChart(nameList,dataMerge) {

      this.chart = echarts.init(this.$el, 'macarons')

      this.chart.setOption({
        title: {
          text: '房屋结构占比图',
          // subtext: '数据统计分析',
          textStyle: {
            color: "#008acd"
          }
        },
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
          left: 'center',
          bottom: '10',
          data: nameList
        },
        series: [
          {
            name: '房屋结构',
            type: 'pie',
            roseType: 'radius',
            radius: [15, 95],
            center: ['50%', '50%'],
            data: dataMerge,
            animationEasing: 'cubicInOut',
            animationDuration: 2600
          }
        ]
      })
    }
  }
}
</script>
