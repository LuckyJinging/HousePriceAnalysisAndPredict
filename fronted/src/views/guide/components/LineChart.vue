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
      default: '350px'
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
    initData(){
      let nameList = []
      let valueList = []
      let attentionList = []
      let j=0
      axios.get('http://127.0.0.1:3000/housedetail/houseDirection').then((response) => {
        // console.log(response.data)
        this.msg = response.data
        for (let i=0 ;i< response.data.length;i++) {
          console.log(response.data[i].district)
          // console.log(response.data[i])
          nameList[i] = response.data[i].district
          valueList[i] = parseInt(response.data[i].cnum )
          attentionList[i] = parseInt((response.data[i].anum))
        }
        // console.log(nameList)
        // console.log(valueList)
        // console.log(attentionList)
        this.initChart(nameList,valueList,attentionList)
      })
    },
    initChart(nameList,valueList,attentionList) {
      this.chart = echarts.init(this.$el, 'macarons')
      this.chart.setOption({
        xAxis: {
          data: ["海淀", "房山", "朝阳", "昌平", "丰台", "通州", "亦庄开发区", "大兴", "顺义", "东城", "西城", "石景山", "门头沟", "密云", "怀柔", "延庆"],
          boundaryGap: false,
          axisTick: {
            show: false
          }
        },
        grid: {
          left: 10,
          right: 10,
          bottom: 20,
          top: 30,
          containLabel: true
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          },
          padding: [5, 10]
        },
        yAxis: [
          {
            name:'数量',
            type:'value',
            max:2000
          },
          {
            name:'平均关注度',
            type:'value',
            max:150

          }
        ],
        legend: {
          data: ['房源数量', '平均关注度']
        },
        series: [{
          name: '房源数量',
          yAxisIndex:0,
          itemStyle: {
            normal: {
              color: '#FF005A',
              lineStyle: {
                color: '#FF005A',
                width: 2
              }
            }
          },
          smooth: true,
          type: 'line',
          data:valueList,
          animationDuration: 2800,
          animationEasing: 'cubicInOut'
        }, {
          name: '平均关注度',
          yAxisIndex:1,
          smooth: true,
          type: 'line',
          itemStyle: {
            normal: {
              color: '#3888fa',
              lineStyle: {
                color: '#3888fa',
                width: 2
              },
              areaStyle: {
                color: '#f3f8ff'
              }
            }
          },
          data:attentionList,
          animationDuration: 2800,
          animationEasing: 'quadraticOut'
        }
        ]
      })
    }
  }
}
</script>
