<template>
  <div :class="className" :style="{height:height,width:width}"/>
</template>

<script>
import echarts from 'echarts'
import axios from 'axios'

require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'
const animationDuration = 2800
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
      default: '360px'
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
      let priceList = []
      let j = 0
      axios.get('http://127.0.0.1:3000/housedetail/houseDecoration').then((response) => {
        // console.log(response.data)
        this.msg = response.data
        for (let i = 0; i < response.data.length; i++) {
          // console.log(response.data[i])
          nameList[i] = response.data[i].decoration
          valueList[i] = parseInt(response.data[i].num)
          priceList[i] = parseFloat(response.data[i].price)
        }
        // console.log(nameList)
        // console.log(valueList)
        // console.log(priceList)
        this.initChart(nameList, valueList, priceList)
      })
    },
    initChart(nameList, valueList, priceList) {
      this.chart = echarts.init(this.$el, 'macarons')
      this.chart.setOption({
        title: {
          text: '装修类型与房源数量和房价的关系',
          // subtext: '数据统计分析',
          textStyle: {
            color: "#008acd"
          }
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          }
        },
        grid: {
          top: '20%',
          left: '2%',
          right: '2%',
          bottom: '25%',
          containLabel: true
        },
        legend: {
          left: 'center',
          bottom: '50',
          data: ['房屋数量', '平均单价']
        },
        xAxis: [
          {
            type: 'category',
            // data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
            data: nameList,
            // axisPointer: {
            //   type: 'shadow'
            // }
          }
        ],
        yAxis: [
          {
            type: 'value',
            name: '数量',
            min: 0,
            max: 10000,
            interval: 1000
          },
          {
            type: 'value',
            name: '价钱/元',
            min: 40000,
            max: 70000,
            interval: 10000
          }
        ],
        series: [
          {
            name: '房屋数量',
            type: 'bar',
            barWidth: 40,
			        itemStyle: {
			            normal: {
			                barBorderRadius: 5,
							//颜色渐变
			                color: '#5de5e0'
			            }
			        },
            // data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
            data: valueList,
            animationDuration
          },
          {
            name: '平均单价',
            type: 'line',

            yAxisIndex: 1,
            // data: [2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2]
            data: priceList,
            animationDuration,
            itemStyle: {
              normal: {
                color: '#6cb041',
                lineStyle: {
                  width: 3//设置线条粗细
                }
              }
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
