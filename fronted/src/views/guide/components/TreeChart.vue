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
      default: '300px'
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
      axios.get('http://127.0.0.1:3000/correlation/getCorrelation').then(
        response => {
          // console.log(response.data)
          let jsonData = response.data
          // console.log(jsonData.length)
          let data = {
            years: "",
            square: "",
            taxtype: "",
            unitPrice: "",
            decoration: "",
            district: "",
            tagList:"",
            housetype_y:"",
            cost:"",
            building_num:"",
            house_num:"",
            bedroom:"",
            livingroom:"",
            totalFloor:"",
            floorNum:"",
            attention:""
          };
          let names = ["建筑年份","面积","容积率", "平米单价", "装修", "地区", "建筑结构", "产权性质", "物业费用", "小区总栋数",
            "绿化率", "卧室数目","物业类型", "客厅数量", "街道", "关注度"];
          let keys = ["years", "square", "taxtype", "unitPrice", "decoration", "district", "tagList", "housetype_y", "cost", "building_num",
            "house_num", "bedroom", "livingroom", "totalFloor", "floorNum", "attention"];
          let dataUp = [];
          for (let i = 0; i < jsonData.length; i++) {
            data.years = Math.abs(parseFloat(jsonData[i].years));
            data.square = Math.abs(parseFloat(jsonData[i].square));
            data.taxtype = Math.abs(parseFloat(jsonData[i].taxtype));
            data.unitPrice = Math.abs(parseFloat(jsonData[i].unitPrice));
            data.decoration = Math.abs(parseFloat(jsonData[i].decoration));
            data.district = Math.abs(parseFloat(jsonData[i].district));
            data.tagList = Math.abs(parseFloat(jsonData[i].tagList));
            data.housetype_y = Math.abs(parseFloat(jsonData[i].housetype_y));
            data.cost = Math.abs(parseFloat(jsonData[i].cost));
            data.building_num = Math.abs(parseFloat(jsonData[i].building_num));
            data.house_num = Math.abs(parseFloat(jsonData[i].house_num));
            data.bedroom = Math.abs(parseFloat(jsonData[i].bedroom));
            data.livingroom = Math.abs(parseFloat(jsonData[i].livingroom));
            data.totalFloor = Math.abs(parseFloat(jsonData[i].totalFloor));
            data.floorNum = Math.abs(parseFloat(jsonData[i].floorNum));
            data.attention = Math.abs(parseFloat(jsonData[i].attention));
            dataUp = Object.keys(data).sort(function (a, b) {
              return data[a] - data[b]
            }).reverse()
          }
          // console.log(dataUp)
          // console.log(data)
          this.initChart(names,keys,data,dataUp)
        }
      )
    },
    initChart(names,keys,data,dataUp) {
      this.chart = echarts.init(this.$el, 'macarons')
      this.chart.setOption({
        title: {
          text: '相关性分析',
          // subtext: '数据统计分析',
          textStyle: {
            color: "#008acd"
          }
        },
        tooltip: {
          trigger: 'item',
          formatter: "{b}: {c}"
        },
        grid: {
          left: '5%',
          right: '5%',
          // top: '5%',
          bottom: '25%',
          containLabel: true
        },
        calculable: false,
        series: [
          {
            name: '相关性',
            y: 'bottom',
            type: 'treemap',
            itemStyle: {
              normal: {
                label: {
                  show: true,
                  formatter: "{b}"
                },
                borderWidth: 1,
                borderColor: '#ccc'
              },
              emphasis: {
                label: {
                  show: true
                },
                color: '#cc99cc',
                borderWidth: 3,
                borderColor: '#996699'
              }
            },
            data: [
              {
                itemStyle: {
                  normal: {
                    color: '#99cccc',
                  }
                },
                value: 6,
                children: [
                  {
                    name: names[keys.indexOf(dataUp[0])],
                    value: data[dataUp[0]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[1])],
                    value: data[dataUp[1]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[2])],
                    value: data[dataUp[2]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[3])],
                    value: data[dataUp[3]].toFixed(3)
                  }
                ]
              },
              {
                itemStyle: {
                  normal: {
                    color: '#99ccff',
                  }
                },
                value: 4,
                children: [
                  {
                    name: names[keys.indexOf(dataUp[4])],
                    value: data[dataUp[4]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[5])],
                    value: data[dataUp[5]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[6])],
                    value: data[dataUp[6]].toFixed(3)
                  }
                ]
              },
              {
                itemStyle: {
                  normal: {
                    color: '#9999cc',
                  }
                },
                value: 4,
                children: [
                  {
                    name: names[keys.indexOf(dataUp[7])],
                    value: data[dataUp[7]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[8])],
                    value: data[dataUp[8]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[9])],
                    value: data[dataUp[9]].toFixed(3)
                  }
                ]
              },
              {
                itemStyle: {
                  normal: {
                    color: '#ccff99',
                  }
                },
                value: 1,
                children: [
                  {
                    name: names[keys.indexOf(dataUp[13])],
                    itemStyle: {
                      normal: {
                        color: '#ccccff',
                      }
                    },
                    value: data[dataUp[13]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[14])],
                    itemStyle: {
                      normal: {
                        color: '#99ccff',
                      }
                    },
                    value: data[dataUp[14]].toFixed(3)
                  },
                  {
                    name: names[keys.indexOf(dataUp[15])],
                    itemStyle: {
                      normal: {
                        color: '#9999cc',
                      }
                    },
                    value: data[dataUp[15]].toFixed(3)
                  },
                  // {
                  //   name: names[keys.indexOf(dataUp[16])],
                  //   itemStyle: {
                  //     normal: {
                  //       color: '#99cccc',
                  //     }
                  //   },
                  //   value: data[dataUp[16]].toFixed(3)
                  // }
                ]
              },
              {
                itemStyle: {
                  normal: {
                    color: '#ccffcc',
                  }
                },
                value: 2,
                children: [
                  {
                    name: names[keys.indexOf(dataUp[10])],
                    value: data[dataUp[10]].toFixed(3)
                  }
                ]
              },
              {
                itemStyle: {
                  normal: {
                    color: '#ccccff',
                  }
                },
                value: 2,
                children: [
                  {
                    name: names[keys.indexOf(dataUp[11])],
                    value: data[dataUp[11]].toFixed(3)
                  }
                ]
              },
              {
                itemStyle: {
                  normal: {
                    color: '#ffffcc',
                  }
                },
                value: 1,
                children: [
                  {
                    name: names[keys.indexOf(dataUp[12])],
                    value: data[dataUp[12]].toFixed(3)
                  }
                ]
              }
            ],
            // animationEasing: 'cubicInOut',
            // animationDuration: 2600
          }
        ]

      })
    }
  }
}
</script>
