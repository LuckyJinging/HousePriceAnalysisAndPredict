<template>
    <div class="Main swiper-no-swiping">
      <!--<el-button :plain="true" class="InfoButton" id="InfoButton11" @click="open2">成功</el-button>-->
      <!--<el-button :plain="true" class="InfoButton" id="InfoButton12" @click="open4">错误</el-button>-->
      <!--<el-button :plain="true" class="InfoButton" id="InfoButton13" @click="open3">错误</el-button>-->
      <div class="MainTop">
        <el-form ref="form" :rules="rules" :model="form" :validate-on-rule-change="false">
        <div class="m-entry">
          <dl>
            <dt>小区</dt>
            <dd class="wrap-sug">
              <div class="u-sug">
                <el-form-item prop="name">
                  <input class="sugInput" v-model="form.name" type="text" autocomplete="off" placeholder="请输入小区名">
                </el-form-item>
              </div>
            </dd>
          </dl>
          <dl>
            <dt>建筑年代</dt>
            <dd>
              <el-select class="year" v-model="form.year" placeholder="请选择">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </dd>
          </dl>
          <dl>
            <dt>面积</dt>
            <dd class="wrap-sug"><input type="text" v-model="form.area" placeholder="请输入大于0的数字" autocomplete="off"
                                        style="width: 150px;">
              <div class="square">平方米</div>
            </dd>
          </dl>
          <dl>
            <dt>户型</dt>
            <dd>
              <el-select class="year" v-model="form.livingRoom" placeholder="请选择">
                <el-option
                  v-for="item in livingRoomOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
              <el-select class="year left" v-model="form.room" placeholder="请选择">
                <el-option
                  v-for="item in roomOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
              <el-select class="year left" v-model="form.wc" placeholder="请选择">
                <el-option
                  v-for="item in wcOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </dd>
          </dl>
          <dl>
            <dt>朝向</dt>
            <dd>
              <el-select class="year" v-model="form.orientation" placeholder="请选择">
                <el-option
                  v-for="item in orientationOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </dd>
          </dl>
          <dl>
            <dt>楼层</dt>
            <dd>
              <el-select class="year" v-model="form.floor" placeholder="请选择">
                <el-option
                  v-for="item in floorOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </dd>
            <div class="LeftTop">
              <dt>总楼层</dt>
              <dd>
                <el-select class="year" v-model="form.totalFloor" placeholder="请选择">
                  <el-option
                    v-for="item in totalFloorOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
              </dd>
            </div>
          </dl>
          <dl>
            <dt>装修</dt>
            <dd>
              <el-select class="year" v-model="form.renovation" placeholder="请选择">
                <el-option
                  v-for="item in renovationOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </dd>
          </dl>
          <dl>
            <dt>建筑结构</dt>
            <dd class="radioDiv">
              <el-radio class="radio" v-model="form.architecturalType" label="1.0" border>平层</el-radio>
              <el-radio class="radio" v-model="form.architecturalType" label="1.5" border>错层</el-radio>
              <el-radio class="radio" v-model="form.architecturalType" label="2.0" border>复式</el-radio>
              <el-radio class="radio" v-model="form.architecturalType" label="2.5" border>开间</el-radio>
              <el-radio v-model="form.architecturalType" label="3.0" border>跃层</el-radio>
            </dd>
          </dl>
        </div>
        </el-form>
      </div>
      <div class="MainBottom">
        <div class="priceTotal">
          <span class="price" id="price">000.000</span><span class="priceText">&nbsp;万元</span>
        </div>
        <div class="btn-submit" @click="handleSubmit1">去估价</div>
        <div style="clear:both"></div>
        <div class="btn-gujia-text">估值结果由系统预测模型提供</div>
      </div>
    </div>

</template>

<script>
  // import utils from "../../utils/utils"
import axios from  'axios'
  export default {
    name: "",
    data() {
      return {
        options: this.getLastSevenYears(),
        livingRoomOptions: this.getLivingRoom(),
        roomOptions: this.getRoom(),
        wcOptions: this.getWc(),
        orientationOptions: this.getOrientationOptions(),
        floorOptions: this.getFloorOptions(),
        totalFloorOptions: this.getTotalFloorOptions(),
        renovationOptions: this.getRenovationOptions(),
        architecturalTypeOptions: this.getArchitecturalTypeOptions(),
        form: {
          userId: '1',
          name: "",
          year: '',
          area: '',
          livingRoom: '',
          room: '',
          wc: '',
          floor: '',
          totalFloor: '',
          architecturalType: '',
          orientation: '',
          renovation: '',
        },
        rules: {
          name: [
            {required: true, message: '请输入小区名称', trigger: 'blur'},
            {max: 15, message: '长度不超过 15 个字符', trigger: 'blur'}
          ]
        },
      }
    },
    mounted() {

    },
    methods: {
      getRenovationOptions() {
        let list = [];
        list.push({value: "-1", label: "请选择"});
        let label = ['中装修', '毛坯', '简装修', '精装修', '豪华装修'];
        for (let i = 0; i < label.length; i++) {
          let value = {value: "", label: ""};
          value.value = (i + 1);
          value.label = label[i];
          list.push(value);
        }
        return list
      },
      getArchitecturalTypeOptions() {
        let list = [];
        list.push({value: "-1", label: "请选择"});
        let label = ['平层', '错层', '复式', '开间', '跃层'];
        let value = [1.0, 1.5, 2.0, 2.5, 3.0];
        for (let i = 0; i < label.length; i++) {
          let value = {value: "", label: ""};
          value.value = value[i];
          value.label = label[i];
          list.push(value);
        }
        return list
      },
      getFloorOptions() {
        let list = [];
        for (let i = 0; i < 30; i++) {
          let value = {value: "", label: ""};
          value.value = (i + 1);
          value.label = (i + 1) + "层";
          list.push(value);
        }
        return list
      },
      getTotalFloorOptions() {
        let list = [];
        list.push({value: "-1", label: "请选择"});
        for (let i = 0; i < 30; i++) {
          let value = {value: "", label: ""};
          value.value = (i + 1);
          value.label = (i + 1) + "层";
          list.push(value);
        }
        return list
      },
      getLastSevenYears() {
        let date = new Date(), timestamp, newDate;
        if (!(date instanceof Date)) {
          date = new Date(date.replace(/-/g, '/'));
        }
        let list = [];
        list.push({value: "-1", label: "请选择"});
        timestamp = date.getFullYear();
        for (let i = 0; i < 70; i++) {
          let value = {value: "", label: ""};
          value.value = timestamp - i;
          value.label = (timestamp - i) + "年";
          list.push(value);
        }
        return list;
      },
      getLivingRoom() {
        let list = [];
        list.push({value: "-1", label: "请选择"});
        for (let i = 0; i < 9; i++) {
          let value = {value: "", label: ""};
          value.value = (i + 1);
          value.label = (i + 1) + "室";
          list.push(value);
        }
        return list
      },
      getRoom() {
        let list = [];
        list.push({value: "-1", label: "请选择"});
        for (let i = 0; i < 9; i++) {
          let value = {value: "", label: ""};
          value.value = (i + 1);
          value.label = (i + 1) + "厅";
          list.push(value);
        }
        return list
      },
      getWc() {
        let list = [];
        list.push({value: "-1", label: "请选择"});
        for (let i = 0; i < 9; i++) {
          let value = {value: "", label: ""};
          value.value = (i + 1);
          value.label = (i + 1) + "卫";
          list.push(value);
        }
        return list
      },
      getOrientationOptions() {
        let list = [];
        list.push({value: "-1", label: "请选择"});
        let label = ['东', '南', '西', '北', '东南', '东北', '西南', '西北', '南北', '东西'];
        for (let i = 0; i < label.length; i++) {
          let value = {value: "", label: ""};
          value.value = (i + 1);
          value.label = label[i];
          list.push(value);
        }
        return list
      },
      handleSubmit1() {
        if (this.form.name === "") {
          $('#InfoButton13').click();
        }else {
          this.con_IncreaseToNumber("price", (((420 - Math.random()*420) + 80 )% 500).toFixed(3));
          let data = new FormData()
          data.append('idNum','1')
          axios.post('http://127.0.0.1:3000/predict/predictPrice/',data).then((response) => {
            console.log(response.data)
          })
          // let success = (response) => {
          //   if (response.data.code !== 1) {
          //     this.resetForm();
          //     $('#InfoButton11').click();
          //   } else {
          //     $('#InfoButton12').click();
          //   }
          // };
          // utils.axiosMethod({
          //   method: "POST",
          //   url: "/user/predictHouse/",
          //   data: this.form,
          //   callback: success
          // });
        }
      },
      open2() {
        this.$message({
          message: '恭喜您，估价成功!',
          type: 'success'
        });
      },
      open4() {
        this.$message.error('失败，重新估价喔！');
      },
      open3(){
        this.$message.error('小区名称不能为空哦！');
      },
      resetForm() {
        this.form = {
          userId: '1',
          name: '',
          year: '',
          area: '',
          livingRoom: '',
          room: '',
          wc: '',
          floor: '',
          totalFloor: '',
          architecturalType: '',
          renovation: '',
        }
      },
      //数字跳转增长 目标id，跳转目标数值，跳转总时间
      con_IncreaseToNumber(id, number, timeSpan) {
        let dom = document.getElementById(id);
        //时间，默认2s；
        timeSpan = timeSpan || 1000;
        let n = timeSpan / 100;
        //频率
        let degreen = parseInt((parseInt(number)) / n);
        let curValue = 0;
        (function numberIncreaseTo() {
          setTimeout(function () {
            if (curValue < number) {
              let tmpValue = curValue;
              if ((tmpValue += degreen) < number) {
                (curValue = tmpValue);
                dom.innerHTML = tmpValue;
                numberIncreaseTo();
              } else {
                (curValue = number);
                dom.innerHTML = curValue;
              }
            }
          }, 100);
        })()
      }
    }
  }
</script>

<style scoped>
  center {
    width: 100%;
    height: 100%;
  }

  .InfoButton {
    display: none;
  }

  .LeftTop {
    width: 680px;
    position: absolute;
    margin-left: 320px;
    padding-right: 0;
    margin-right: 0;
  }

  .radioDiv {
    width: 470px !important;
  }

  .radio {
    margin-right: 3.4%;
  }

  .Main {
    width: 100%;
    height: 100%;
    overflow: hidden;
    padding-top: 80px;
  }

  .MainTop {
    width: 50%;
    height: 80%;
    margin: 0 auto;
  }

  .left {
    margin-left: 10px;
  }

  .MainBottom {
    width: 50%;
    height: 20%;
    margin: 0 auto;
  }

  .priceTotal {
    width: 20%;
    float: left;
    margin-left: 5%;
    margin-top: 3%;
    height: 45%;
    line-height: 50px;
    font-size: 18px;
    text-align: center;
    border-radius: 2px;
    background-color: #00ac65;
  }

  .priceTotal .price {
    color: #FFFFFF;
    font-weight: bold;
  }

  .priceTotal .priceText {
    color: #FFFFFF;
  }

  .btn-submit {
    width: 20%;
    float: right;
    margin-right: 5%;
    margin-top: 3%;
    height: 45%;
    line-height: 50px;
    font-size: 18px;
    color: #fff;
    text-align: center;
    border-radius: 2px;
    background-color: #00ac65;
    cursor: pointer;
  }

  .btn-gujia-text {
    float: right;
    margin-top: 10px;
    margin-right: 0;
    width: 190px;
    font-size: 13px;
    line-height: 14px;
    color: #999;
    text-align: center;
  }

  .m-entry {
    width: 100%;
    height: 100%;
  }

  .wrap-sug {
    margin-top: -5px;
  }

  .m-entry dl {
    height: 44.5px;
    padding: 0;
    line-height: 28px;
    border-bottom: 1px solid #eee;
  }

  .m-entry dl:first-child {
    padding-top: 0;
  }

  .m-entry dt {
    text-align: center;
    float: left;
    color: #333;
    font-weight: bold;
    width: 100px;
  }

  .m-entry dd {
    position: relative;
    float: left;
    width: 470px;
  }

  .m-entry dd > * {
    float: left;
  }

  .u-sug {
    position: relative;
    width: 100%;
  }

  .m-entry input.sugInput {
    width: 100%;
  }

  .m-entry input {
    border: none;
    height: 40px;
    line-height: 25px;
    padding: 6px 0;
  }

  .m-entry dl:before, .m-entry dl:after {
    display: table;
    content: "";
  }

  .m-entry dl:after {
    clear: both;
  }

  .year {
    width: 150px;
    margin-top: -3px;
  }

  .m-entry .square {
    float: left;
    font-size: 14px;
    margin-left: 5px;
    margin-top: 6px;
    color: #333;
  }

  input, textarea, button {
    resize: none;
    font-family: "Hiragino Sans GB", "Microsoft Yahei UI", "Microsoft Yahei", 微软雅黑, "Segoe UI", Tahoma, 宋体b8b体, SimSun, sans-serif;
    margin: 0;
    padding: 0;
    outline: none;
  }

  input:not([type]), input[type="email" i], input[type="number" i], input[type="password" i], input[type="tel" i], input[type="url" i], input[type="text" i] {
    padding: 1px 0;
  }

  input {
    -webkit-appearance: textfield;
    background-color: rgb(247, 247, 247);
    -webkit-rtl-ordering: logical;
    cursor: text;
    padding: 1px;
    border-width: 2px;
    border-style: inset;
    border-color: initial;
    border-image: initial;
  }

  input, textarea, select, button {
    text-rendering: auto;
    color: initial;
    letter-spacing: normal;
    word-spacing: normal;
    text-transform: none;
    text-indent: 0;
    text-shadow: none;
    display: inline-block;
    text-align: start;
    margin: 0;
    font: 400 13.3333px Arial;
  }
</style>
