<template>
  <div class="dashboard-editor-container">
    <!--<github-corner class="github-corner" />-->

    <panel-group @handleSetLineChartData="handleSetLineChartData"/>
    <!--折线图-->
    <el-row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
      <line-chart :chart-data="lineChartData"/>
    </el-row>
    <!--房屋推荐-->
    <el-row :gutter="32">
      <div style="padding-left: 18px; font-size: 13px; padding-bottom: 10px;">
        <h1>二手好房 为您而选</h1>
        好房源那么多，我们为你精选，我们会越来越懂你
      </div>
      <el-col :xs="24" :sm="24" :lg="6" style="margin-bottom: 10px;">
        <el-card :body-style="{ padding: '0px' }">
          <div class="houseRecommend">
            <img src="../../../../static/image/house1.jpg"
                 class="image">
            <div style="padding: 14px; text-align: left; display: inline-block;width: 300px">
              <span>朝阳·望京</span><br>
              <span>澳洲康都</span>
              <div class="bottom clearfix">
                <time class="time">2室1厅·86.8平米</time>
                <el-button type="text" class="button">698万</el-button>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="6">
        <el-card :body-style="{ padding: '0px' }">
          <div class="houseRecommend">
            <img src="../../../../static/image/house2.jpg"
                 class="image">
            <div style="padding: 14px; text-align: left; display: inline-block;width: 300px">
              <span>朝阳·劲松</span><br>
              <span>农光里</span>
              <div class="bottom clearfix">
                <time class="time">3室1厅·94.48平米</time>
                <el-button type="text" class="button">480万</el-button>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="6">
        <el-card :body-style="{ padding: '0px',align:'center' }">
          <div class="houseRecommend">
            <img src="../../../../static/image/house3.jpg"
                 class="image">
            <div style="padding: 14px; text-align: left; display: inline-block;width: 300px">
              <span>西城·菜户营</span><br>
              <span>乐城</span>
              <div class="bottom clearfix">
                <time class="time">2室1厅·87.31平米</time>
                <el-button type="text" class="button">658万</el-button>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="6">
        <el-card :body-style="{ padding: '0px' }">
          <div class="houseRecommend">
            <img src="../../../../static/image/house4.jpg"
                 class="image">
            <div style="padding: 14px; text-align: left; display: inline-block;width: 300px">
              <span>朝阳·亚运村</span><br>
              <span>卧龙小区</span>
              <div class="bottom clearfix">
                <time class="time">2室1厅·74.79平米</time>
                <el-button type="text" class="button">740万</el-button>
              </div>
            </div>
          </div>

        </el-card>
      </el-col>
    </el-row>
    <!--小区推荐-->
    <el-row :gutter="32">
      <div style="padding-left: 18px; font-size: 13px; padding-bottom: 10px">
        <h1>优质小区 为您推荐</h1>
        纵览小区，恋上这座城
      </div>
      <el-col :xs="24" :sm="24" :lg="8">
        <el-card :body-style="{ padding: '0px' }">
          <div class="cardBody">
            <img src="../../../../static/image/community1.jpg"
                 class="image">
            <div style="padding: 14px; text-align: left; display: inline-block;width: 300px">
              <span style="font-size: larger;font-weight: bold;line-height: 32px;">远洋山水</span><br>
              <span>63488元/平</span>
              <span style="float: right;font-size: small;color: gray;">2003年建</span>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <el-card :body-style="{ padding: '0px' }">
          <div class="cardBody">
            <img src="../../../../static/image/community2.jpg"
                 class="image">
            <div style="padding: 14px; text-align: left; display: inline-block;width: 300px">
              <span style="font-size: larger;font-weight: bold;line-height: 32px;">芍药居北里</span><br>
              <span>77633元/平</span>
              <span style="float: right;font-size: small;color: gray;">1994年建</span>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <el-card :body-style="{ padding: '0px',align:'center' }">
          <div class="cardBody">
            <img src="../../../../static/image/community3.jpg"
                 class="image">
            <div style="padding: 14px; text-align: left; display: inline-block;width: 300px">
              <span style="font-size: larger;font-weight: bold;line-height: 32px;">天通苑东一区</span><br>
              <span>34992元/平</span>
              <span style="float: right;font-size: small;color: gray;">2001年建</span>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import axios from 'axios'
import PanelGroup from './components/PanelGroup'
import LineChart from './components/LineChart'
import RaddarChart from './components/RaddarChart'
import PieChart from './components/PieChart'
import BarChart from './components/BarChart'


export default {
  name: 'DashboardAdmin',
  components: {
    PanelGroup,
    LineChart,
    RaddarChart,
    PieChart,
    BarChart
  },
  data() {
    return {
      lineChartDataAll: {
        houseNum: {
          expectedData: [100, 120, 161, 134, 105, 160, 165],
          nameList:[],
          typeString:''
        },
        priceAvg: {
          expectedData: [200, 192, 120, 144, 160, 130, 140],
          nameList:[],
          typeString:''
        },
        attentionAvg: {
          expectedData: [80, 100, 121, 104, 105, 90, 100],
          nameList:[],
          typeString:''
        },
        squareAvg: {
          expectedData: [130, 140, 141, 142, 145, 150, 160],
          nameList:[],
          typeString:''
        }
      },
      lineChartData: {
          expectedData: [100, 120, 161, 134, 105, 160, 165],
          nameList:[],
          typeString:''
        },
      currentDate: new Date()
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.initData()
    })
  },
  methods: {
    initData() {
      let upriceList = []
      let numList = []
      let anumList = []
      let snumList = []
      let nameList = []
      axios.get('http://127.0.0.1:3000/housedetail/houseDirectionAll').then((response) => {
        // console.log(response.data)
        this.msg = response.data
        for (let i = 0; i < response.data.length; i++) {
          // console.log(response.data[i])
          nameList[i] = response.data[i].district
          upriceList[i] = parseFloat(response.data[i].uprice).toFixed(2)
          numList[i] = parseInt(response.data[i].num)
          anumList[i] = parseFloat(response.data[i].anum).toFixed(2)
          snumList[i] = parseFloat(response.data[i].snum).toFixed(2)

        }
        this.lineChartDataAll.houseNum.expectedData=numList
        this.lineChartDataAll.priceAvg.expectedData=upriceList
        this.lineChartDataAll.attentionAvg.expectedData=anumList
        this.lineChartDataAll.squareAvg.expectedData=snumList
        this.lineChartDataAll.houseNum.nameList=nameList
        this.lineChartDataAll.priceAvg.nameList=nameList
        this.lineChartDataAll.attentionAvg.nameList=nameList
        this.lineChartDataAll.squareAvg.nameList=nameList
        this.lineChartDataAll.houseNum.typeString='房源数量'
        this.lineChartDataAll.priceAvg.typeString='平均单价'
        this.lineChartDataAll.attentionAvg.typeString='平均关注度'
        this.lineChartDataAll.squareAvg.typeString='平均面积'
        this.lineChartData.expectedData=snumList
        this.lineChartData.nameList=nameList
        this.handleSetLineChartData('houseNum')
      })
    },
    handleSetLineChartData(type) {
      this.lineChartData = this.lineChartDataAll[type]
    }
  }
}
</script>

<style lang="scss" scoped>
  .dashboard-editor-container {
    padding: 32px;
    background-color: rgb(240, 242, 245);
    position: relative;

    .github-corner {
      position: absolute;
      top: 0px;
      border: 0;
      right: 0;
    }

    .houseRecommend {
      padding: 5px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }

    .cardBody {
      padding: 5px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }

    .chart-wrapper {
      background: #fff;
      padding: 16px 16px 0;
      margin-bottom: 32px;
    }
  }

  @media (max-width: 1024px) {
    .chart-wrapper {
      padding: 8px;
    }
  }

  .time {
    font-size: 13px;
    color: #999;
  }

  .bottom {
    margin-top: 13px;
    line-height: 12px;

  }

  .button {
    padding: 0;
    font-size: 22px;
    float: right;
    margin-top: -35px;
  }

  .image {
    width: 300px;
    /*padding: 20px;*/
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }

  .clearfix:after {
    clear: both
  }
</style>
