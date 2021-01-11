<template>
  <div style="float: left; text-align: left; margin-left: 20px">
    <p>房屋编号：{{ msg["houseId"] }}</p>
    <p>小区名称：{{ msg["communityName"] }}</p>
    <p>房屋大小：{{ msg["houseSize"] }}</p>
    <p>房屋总价：{{ msg["housePrice"] }}</p>
    <div style="width: 800px; height: 350px" id="pieGraph"></div>
  </div>
</template>

<script>
export default {
  name: "test",
  data() {
    return {
      msg: {},
    };
  },
  created() {
    axios.get("http://127.0.0.1:3000/tests/mytest").then((response) => {
      console.log(response.data);
      this.msg = response.data;
    });
  },
  mounted: function () {
    this.doShow();
  },
  methods: {
    doShow() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = $echarts.init(document.getElementById("pieGraph"));
      myChart.showLoading();
      let nameList = [0, 0, 0, 0, 0];
      let valueList = ["", "", "", "", ""];
      // axios.get("http://127.0.0.1:8000/myTest/countTest").then((response) => {
      //   for (let i = 0; i < response.data.length; i++) {
      //     nameList[i] = response.data[i].name;
      //     valueList[i] = response.data[i].value;
      //   }
        
      // });
      this.doDraw(myChart, valueList, nameList);
    },
    doDraw(myChart, valueList, nameList) {
      let option = {
        tooltip: {
          trigger: "item",
          formatter: "{a} <br/>{b}: {c} ({d}%)",
        },
        legend: {
          orient: "vertical",
          left: 10,
          data: ["直接访问", "邮件营销", "联盟广告", "视频广告", "搜索引擎"],
        },
        series: [
          {
            name: "访问来源",
            type: "pie",
            radius: ["50%", "70%"],
            avoidLabelOverlap: false,
            label: {
              show: false,
              position: "center",
            },
            emphasis: {
              label: {
                show: true,
                fontSize: "30",
                fontWeight: "bold",
              },
            },
            labelLine: {
              show: false,
            },
            data: [
              { value: 335, name: "直接访问" },
              { value: 310, name: "邮件营销" },
              { value: 234, name: "联盟广告" },
              { value: 135, name: "视频广告" },
              { value: 1548, name: "搜索引擎" },
            ],
          },
        ],
      };
      myChart.clear();
      // 绘制图表，this.echarts1_option是数据
      myChart.setOption(option, true);
      myChart.hideLoading();
    },
  },
};
</script>

<style scoped>
</style>
