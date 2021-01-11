<template>
  <div class="app-container">
    <el-row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
      <line-chart :chart-data="lineChartData" />
    </el-row>
    <!--雷达图、饼图、条形图-->
    <el-row :gutter="32" style="margin-top: 20px">
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <tree-chart />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <pie-chart />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <!--<bar-chart />-->
          <bar-line-chart />
        </div>
      </el-col>
    </el-row>
    <!--条形图-->
    <el-row :gutter="32" style="margin-top: 20px">
      <el-col :xs="24" :sm="24" :lg="16">
        <div class="chart-wrapper">
          <bar-chart-v1 />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <bar-chart-v2 />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>

import LineChart from './components/LineChart'
import RaddarChart from './components/RaddarChart'
import PieChart from './components/PieChart'
import BarChart from './components/BarChart'
import BarLineChart from './components/BarLineChart'
import BarChartV1 from './components/BarChartV1'
import BarChartV2 from './components/BarChartV2'
import TreeChart from './components/TreeChart'
export default {
  name: 'Guide',
  components: {
    LineChart,
    RaddarChart,
    PieChart,
    BarChart,
    BarLineChart,
    BarChartV1,
    BarChartV2,
    TreeChart
  },
  data() {
    return {

    }
  },
  mounted() {

  },
  methods: {

  }
}
</script>
