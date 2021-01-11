<template>
  <div :class="className" :style="{height:height,width:width}"/>
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
      default: '400px'
    },
    autoResize: {
      type: Boolean,
      default: true
    },
    chartData: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      chart: null
    }
  },
  watch: {
    chartData: {
      deep: true,
      handler(val) {
        this.setOptions(val)
      }
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
    initData() {
      let nameList = []
      let valueList = []
      axios.get('http://127.0.0.1:3000/housedetail/houseTagList').then((response) => {
        // console.log(response.data)
        this.msg = response.data
        for (let i = 0; i < response.data.length; i++) {
          // console.log(response.data[i])
          nameList[i] = response.data[i].tagList
          valueList[i] = parseFloat(response.data[i].total).toFixed(2)
        }
        // console.log(nameList)
        // console.log(valueList)
        this.initChart(nameList, valueList)
      })
    },
    initChart(nameList, valueList) {
      this.chart = echarts.init(this.$el, 'macarons')
      this.chart.setOption({
        title: {
          text: '地铁线周边房屋每平米价格'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          // left:'right',
          // top:'40',
          right:'100',
          data: ['平米单价']
        },
        calculable: true,
        xAxis: [
          {
            type: 'category',
            data: nameList,
            axisLabel: {
            color: '#000000',
            rotate: 30,
            interval: 0
          },
          }
        ],
        yAxis: [
          {
            type: 'value'
          }
        ],
        series: [
          {
            name: '平米单价',
            type: 'bar',
            barWidth: 25,
			        itemStyle: {
			            normal: {
			                barBorderRadius: 5,
							//颜色渐变
			                color: new echarts.graphic.LinearGradient(
			                    0, 0, 0, 1,
			                    [
			                        {offset: 1, color: '#f08eea'},
			                        {offset: 0, color: '#3EACE5'}
			                    ]
			                )
			            }
			        },
            data: valueList,
            markPoint: {
              data: [
                {type: 'max', name: '最大值'},
                {type: 'min', name: '最小值'}
              ]
            },
            markLine: {
              data: [
                {type: 'average', name: '平均值'}
              ]
            }
          }
        ]
      })
    }
  }
}
</script>

<style scoped>

</style>
