<template>
  <div class="app-container documentation-container">
    <div class="importSearch">
      <div class="leftInput">
        <el-button :plain="true" id="InfoButton6" class="InfoButton" @click="open3">警告</el-button>
        <el-button :plain="true" id="InfoButton7" class="InfoButton" @click="open2">成功</el-button>
        <el-form ref="form" :model="form" label-width="100px">
          <el-row :gutter="2" class="row1" style="margin: 0">
            <el-col :span="8" style="padding: 0">
              <div class="grid-content bg-purple">
                <el-form-item label="售价" class="selectLabel">
                  <el-select v-model="form.price" class="selectInput">
                    <el-option label="不限" value="-1" selected></el-option>
                    <el-option label="200万以下" value="0,200"></el-option>
                    <el-option label="200-500万" value="200,500"></el-option>
                    <el-option label="500-1000万" value="500,1000"></el-option>
                    <el-option label="1000-1500万" value="1000,1500"></el-option>
                    <el-option label="1500-2000万" value="1500,2000"></el-option>
                    <el-option label="2000万以上" value="2000,5000"></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="8" style="padding: 0">
              <div class="grid-content bg-purple">
                <el-form-item label="房型" class="selectLabel">
                  <el-select v-model="form.livingRoom" class="selectInput">
                    <el-option label="不限" value="-1" selected></el-option>
                    <el-option label="一室" value="1"></el-option>
                    <el-option label="两室" value="2"></el-option>
                    <el-option label="三室" value="3"></el-option>
                    <el-option label="四室" value="4"></el-option>
                    <el-option label="五室及以上" value="5"></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="8" style="padding: 0">
              <div class="grid-content bg-purple">
                <el-form-item label="面积" class="selectLabel">
                  <el-select v-model="form.area" class="selectInput">
                    <el-option label="不限" value="-1" selected></el-option>
                    <el-option label="90平以下" value="0,90"></el-option>
                    <el-option label="90-110平" value="90,110"></el-option>
                    <el-option label="110-130平" value="110,130"></el-option>
                    <el-option label="130-150平" value="130,150"></el-option>
                    <el-option label="150-200平" value="150,200"></el-option>
                    <el-option label="200平以上" value="200,1000"></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row :gutter="2" class="row2" style="margin: 0">
            <el-col :span="8" style="padding: 0">
              <div class="grid-content bg-purple">
                <el-form-item label="楼层" class="selectLabel">
                  <el-select v-model="form.buildType" class="selectInput">
                    <el-option label="不限" value="-1" selected></el-option>
                    <el-option label="低层" value="1"></el-option>
                    <el-option label="中层" value="2"></el-option>
                    <el-option label="高层" value="3"></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="8" style="padding: 0">
              <div class="grid-content bg-purple">
                <el-form-item label="装修" class="selectLabel">
                  <el-select v-model="form.orientation" class="selectInput">
                    <el-option label="不限" value="-1" selected></el-option>
                    <el-option label="毛坯" value="2"></el-option>
                    <el-option label="简装修" value="3"></el-option>
                    <el-option label="中装修" value="1"></el-option>
                    <el-option label="精装修" value="4"></el-option>
                    <el-option label="豪华装修" value="5"></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="8" style="padding: 0">
              <div class="grid-content bg-purple">
                <el-form-item label="楼龄" class="selectLabel">
                  <el-select v-model="form.year" class="selectInput">
                    <el-option label="不限" value="-1" selected></el-option>
                    <el-option label="5年以内" value="0,5"></el-option>
                    <el-option label="10年以内" value="5,10"></el-option>
                    <el-option label="15年以内" value="10,15"></el-option>
                    <el-option label="20年以内" value="15,20"></el-option>
                    <el-option label="20年以上" value="20,70"></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
        </el-form>
      </div>
      <div class="rightSubmit">
        <div class="btn-submit" @click="handleSubmit">去找房</div>
      </div>
    </div>
    <center>
    <div class="map">
      <div id="container" class="map"></div>
      <div class="control">
        <ul>
          <li class="distance" @click="distance">距离测量</li>
          <li class="area" @click="area">面积测量</li>
          <li class="zoomUp" @click="zoomDown">区域放大</li>
          <li class="zoomIn" @click="zoomUp">区域缩小</li>
          <!--<li class="district" @click="district">行政区划</li>-->
          <li class="viewMode" @click="viewMode">3D地图</li>
          <li class="circle" @click="circle">画圈找房</li>
        </ul>
      </div>
    </div>
    </center>
  </div>
</template>

<script>
import AMap from 'AMap'
import axios from 'axios'
import img from './pos.png'
export default {
  name: '',
  data() {
    return {
      form: {
        userId: '1',
        price: '-1',
        livingRoom: '-1',
        area: '-1',
        buildType: '-1',
        orientation: '-1',
        year: '-1',
      },
      Makes: [],
      makes: [],
      distances: 0,
      up: 0,
      in: 0,
      areas: 0,
      view: 0,
      districtCount: 0,
      circles: 0,
      district: null,
      menu: null,
      mouseTool: null,
      map: null,
      overlays: [],
      polygons: [],
    }
  },
  created() {
    this.$root.$on('transferMakes', (val) => {
      this.Makes = val;
      this.mapInit();
    })
  },
  mounted() {
    this.showData();
  },
  methods: {
    handleSubmit() {
      // alert(this.form);
      let success = (response) => {
        let state = response.data.code;
        if (parseInt(state) === 1) {
          $('#InfoButton6').click();
        } else {
          let jsonData = JSON.parse(response.data.data);
          let makes = [];
          for (let i = 0; i < jsonData.length; i++) {
            if (jsonData[i].addr.lng != null && jsonData[i].addr.lat != null) {
              let k = this.bd_decrypt(jsonData[i].addr.lng, jsonData[i].addr.lat);
              let make = {count: '', lng: '', lat: '', addr: '', totalPrice: '', area: ''};
              make.count = jsonData[i].count;
              make.lng = k.lng;
              make.lat = k.lat;
              make.addr = jsonData[i].addr.addr;
              make.totalPrice = jsonData[i].price;
              make.area = jsonData[i].area;
              makes.push(make);
            }
          }
          this.$root.$emit('transferMakes', makes);
          $('#InfoButton7').click();
        }
      };

      // 根据条件找房
      // axios.post()
      // utils.axiosMethod({
      //   method: "POST",
      //   url: "/user/findHouse/",
      //   data: this.form,
      //   callback: success
      // })
    },
    open2() {
      this.$message({
        message: '恭喜您，查询成功!',
        type: 'success'
      });
    },
    open3() {
      this.$message({
        message: '未找到相应的房源信息，选择其他的试试！',
        type: 'warning'
      });
    },
    //百度坐标转高德（传入经度、纬度）
    bd_decrypt(bd_lng, bd_lat) {
      let X_PI = Math.PI * 3000.0 / 180.0;
      let x = bd_lng - 0.0065;
      let y = bd_lat - 0.006;
      let z = Math.sqrt(x * x + y * y) - 0.00002 * Math.sin(y * X_PI);
      let theta = Math.atan2(y, x) - 0.000003 * Math.cos(x * X_PI);
      let gg_lng = z * Math.cos(theta);
      let gg_lat = z * Math.sin(theta);
      return {lng: gg_lng, lat: gg_lat}
    },
    //高德坐标转百度（传入经度、纬度）
    bd_encrypt(gg_lng, gg_lat) {
      let X_PI = Math.PI * 3000.0 / 180.0;
      let x = gg_lng, y = gg_lat;
      let z = Math.sqrt(x * x + y * y) + 0.00002 * Math.sin(y * X_PI);
      let theta = Math.atan2(y, x) + 0.000003 * Math.cos(x * X_PI);
      let bd_lng = z * Math.cos(theta) + 0.0065;
      let bd_lat = z * Math.sin(theta) + 0.006;
      return {
        bd_lat: bd_lat,
        bd_lng: bd_lng
      };
    },


    showData() { // 获取各点的坐标
      // this.mapInit();
      axios.get('http://127.0.0.1:3000/houseposition/getPosition').then(
        response => {
        let jsonData = response.data;
        console.log(jsonData)
        let makes = [];
        for (let i = 0; i < jsonData.length; i++) {
          if (jsonData[i].lng != null && jsonData[i].lat != null) {
            let k = this.bd_decrypt(jsonData[i].lng, jsonData[i].lat);
            let make = {count: '', lng: '', lat: '', year: '', totalPrice: '', district: '',community:''};
            make.count = jsonData[i].num;
            make.lng = k.lng;
            make.lat = k.lat;
            make.year = jsonData[i].year;
            make.totalPrice = jsonData[i].price;
            make.district = jsonData[i].district;
            make.community=jsonData[i].community;
            makes.push(make);
          }
        }

        this.Makes = [];
        this.Makes = makes;
        console.log(this.Makes)
        this.mapInit();
      })
    },
    showInfoMove: function (e) {
      if (!this.district) {
        //实例化DistrictSearch
        let opts = {
          subdistrict: 0,   //获取边界不需要返回下级行政区
          extensions: 'all',  //返回行政区边界坐标组等具体信息
          level: 'district'  //查询行政级别为 市
        };
        this.district = new AMap.DistrictSearch(opts);
      }
      this.map.remove(this.polygons);
      this.polygons = [];
      let map = this.map;
      let polygons = this.polygons;
      let dis = this.district;
      this.map.getCity(function (info) {
        let district = info.district;
        //行政区查询
        dis.search(district, function (status, result) {
          let bounds = result.districtList[0].boundaries;
          if (bounds) {
            for (let i = 0, l = bounds.length; i < l; i++) {
              //生成行政区划polygon
              let polygon = new AMap.Polygon({
                strokeWeight: 1,
                path: bounds[i],
                fillOpacity: 0.01,
                fillColor: '#80d8ff',
                strokeColor: '#a7dfff'
              });
              polygons.push(polygon);
            }
          }
          map.add(polygons);
        });
      });
    },
    mapZoomend: function (e) {
      let zoom = this.map.getZoom(); //获取当前地图级别
      if (zoom <= 9) {
        for (let i = 0; i < this.makes.length; i++) {
          this.makes[i].hide();
        }
      } else {
        for (let i = 0; i < this.makes.length; i++) {
          this.makes[i].show();
        }
      }
    },
    rightClick: function (e) {
      this.menu.open(this.map, e.lnglat);
      contextMenuPositon = e.lnglat;
    },
    draw(type) {
      switch (type) {
        case 'rule': {
          this.mouseTool.rule({
            startMarkerOptions: {//可缺省
              icon: new AMap.Icon({
                size: new AMap.Size(19, 31),//图标大小
                imageSize: new AMap.Size(19, 31),
                image: "https://webapi.amap.com/theme/v1.3/markers/b/start.png"
              })
            },
            endMarkerOptions: {//可缺省
              icon: new AMap.Icon({
                size: new AMap.Size(19, 31),//图标大小
                imageSize: new AMap.Size(19, 31),
                image: "https://webapi.amap.com/theme/v1.3/markers/b/end.png"
              }),
              offset: new AMap.Pixel(-9, -31)
            },
            midMarkerOptions: {//可缺省
              icon: new AMap.Icon({
                size: new AMap.Size(19, 31),//图标大小
                imageSize: new AMap.Size(19, 31),
                image: "https://webapi.amap.com/theme/v1.3/markers/b/mid.png"
              }),
              offset: new AMap.Pixel(-9, -31)
            },
            lineOptions: {//可缺省
              strokeStyle: "solid",
              strokeColor: "#FF33FF",
              strokeOpacity: 1,
              strokeWeight: 2
            }
            //同 RangingTool 的 自定义 设置，缺省为默认样式
          });
          break;
        }
        case 'measureArea': {
          this.mouseTool.measureArea({
            strokeColor: '#80d8ff',
            fillColor: '#80d8ff',
            fillOpacity: 0.3
            //同 Polygon 的 Option 设置
          });
          break;
        }
        case 'zoomIn': {
          this.mouseTool.rectZoomIn({
            strokeColor: '#80d8ff',
            fillColor: '#80d8ff',
            fillOpacity: 0.3
            //同 Polygon 的 Option 设置
          });
          break;
        }
        case 'zoomOut': {
          this.mouseTool.rectZoomOut({
            strokeColor: '#80d8ff',
            fillColor: '#80d8ff',
            fillOpacity: 0.3
            //同 Polygon 的 Option 设置
          });
          break;
        }
        case 'polyline': {
          this.mouseTool.polyline({
            strokeColor: '#80d8ff'
            //同Polyline的Option设置
          });
          break;
        }
        case 'rectangle': {
          this.mouseTool.rectangle({
            fillColor: '#00b0ff',
            strokeColor: '#80d8ff'
            //同Polygon的Option设置
          });
          break;
        }
        case 'circle': {
          this.mouseTool.circle({
            fillColor: '#00b0ff',
            strokeColor: '#80d8ff'
            //同Circle的Option设置
          });
          break;
        }
        case defaultStatus: {
          break;
        }
      }
    },
    distance() {
      this.distances += 1;
      if (this.distances % 2 === 1) {
        $('.control').find('li').each(function () {
          if ($(this).hasClass('active')) {
            $(this).click();
            $(this).removeClass('active')
          }
        });
        $('.distance').addClass('active');
        // this.map.off('mousemove', this.showInfoMove);
        this.mouseTool.off('draw', this.addOverlays);
        this.map.off('rightclick', this.rightClick);
        this.draw('rule');
      } else {
        $('.distance').removeClass('active');
        this.map.on('rightclick', this.rightClick);
        this.mouseTool.close(true)//关闭，并清除覆盖物
      }
    },
    area() {
      this.areas += 1;
      if (this.areas % 2 === 1) {
        $('.control').find('li').each(function () {
          if ($(this).hasClass('active')) {
            $(this).click();
            $(this).removeClass('active')
          }
        });
        $('.area').addClass('active');
        // this.map.off('mousemove', this.showInfoMove);
        this.mouseTool.off('draw', this.addOverlays);
        this.map.off('rightclick', this.rightClick);
        this.draw('measureArea');
      } else {
        $('.area').removeClass('active');
        this.map.on('rightclick', this.rightClick);
        this.mouseTool.close(true)//关闭，并清除覆盖物
      }
    },
    zoomUp() {
      this.up += 1;
      if (this.up % 2 === 1) {
        $('.control').find('li').each(function () {
          if ($(this).hasClass('active')) {
            $(this).click();
            $(this).removeClass('active')
          }
        });
        $('.zoomIn').addClass('active');
        // this.map.off('mousemove', this.showInfoMove);
        this.mouseTool.off('draw', this.addOverlays);
        this.map.off('rightclick', this.rightClick);
        this.draw('zoomOut');
      } else {
        $('.control').find('li').removeClass('active');
        this.init();
        $('.zoomIn').removeClass('active');
        this.map.on('rightclick', this.rightClick);
        this.mouseTool.close(true)//关闭，并清除覆盖物
      }
    },
    zoomDown() {
      this.in += 1;
      if (this.in % 2 === 1) {
        $('.control').find('li').each(function () {
          if ($(this).hasClass('active')) {
            $(this).click();
            $(this).removeClass('active')
          }
        });
        $('.zoomUp').addClass('active');
        // this.map.off('mousemove', this.showInfoMove);
        this.mouseTool.off('draw', this.addOverlays);
        this.map.off('rightclick', this.rightClick);
        this.draw('zoomIn');
      } else {
        $('.zoomUp').removeClass('active');
        this.map.on('rightclick', this.rightClick);
        this.mouseTool.close(true)//关闭，并清除覆盖物
      }
    },
    // district() {
    //   this.disksCount += 1;
    //   if (this.disksCount % 2 === 1) {
    //     $('.control').find('li').each(function () {
    //       if ($(this).hasClass('active')) {
    //         $(this).click();
    //         $(this).removeClass('active')
    //       }
    //     });
    //     $('.district').addClass('active');
    //     this.mouseTool.off('draw', this.addOverlays);
    //     this.map.off('rightclick', this.rightClick);
    //     this.map.on('mousemove', this.showInfoMove);
    //   } else {
    //     $('.district').removeClass('active');
    //     this.map.on('rightclick', this.rightClick);
    //     this.map.off('mousemove', this.showInfoMove);
    //   }
    // },
    viewMode() {
      this.view += 1;
      if (this.view % 2 === 1) {
        this.mapInit1();
        $('.control').find('li').each(function () {
          if ($(this).hasClass('active')) {
            $(this).click();
            $(this).removeClass('active')
          }
        });
        this.mouseTool.off('draw', this.addOverlays);
        $('.viewMode').addClass('active');
        this.map.off('rightclick', this.rightClick);
      } else {
        this.mapInit();
        $('.viewMode').removeClass('active');
        this.map.on('rightclick', this.rightClick);
        // this.map.off('mousemove', this.showInfoMove);
        this.mouseTool.close(true);//关闭，并清除覆盖物
      }
    },
    mapInit() {
      let map = new AMap.Map('container', {
        resizeEnable: true, //是否监控地图容器尺寸变化
        dragEnable: true,
        rotateEnable: true,
        doubleClickZoom: true,
        pitchEnable: true,
        pitch: 0,
        rotation: 0,
        viewMode: '2D',
        buildingAnimation: true,//楼块出现是否带动画
        expandZoomRange: true,
        zoom: 12, //初始化地图层级
        center: [116.403694,39.913385] //初始化地图中心点
      });
      map.on('complete', function () {
        //添加地图插件  工具条、比例尺、鹰眼、地图类型、定位
        map.plugin(['AMap.ToolBar', 'AMap.Scale', 'AMap.OverView', 'AMap.MapType', 'AMap.Geolocation', 'AMap.ControlBar'], function () {
          //创建并添加工具控件,上下左右移动，以及缩放
          let scala = new AMap.Scale({offset: new AMap.Pixel(50, 35)});
          let overView = new AMap.OverView({isOpen: true, offset: new AMap.Pixel(10, 10),});
          let toolBar = new AMap.ToolBar({ruler: false, noIpLocate: true, offset: new AMap.Pixel(10, 10)},);
          let geolocation = new AMap.Geolocation();
          let mapType = new AMap.MapType({defaultType: 0, showTraffic: false, showRoad: true,});
          // let controlBar = new AMap.ControlBar({showZoomBar:false, showControlButton:true, position:{right:'10px', top:'10px'}});
          // map.addControl(controlBar);
          map.addControl(scala);
          map.addControl(overView);
          map.addControl(toolBar);
          map.addControl(geolocation);
          map.addControl(mapType);
        });

        $('.control').css('display', 'block');
        $('.amap-locate').css('left', '0px');
        $('.amap-zoomcontrol').css('left', '0px');
        $('.amap-maptype-list p').css('width', '115px');
      });

      this.initActive(map);
    },
    mapInit1() {
      let map = new AMap.Map('container', {
        resizeEnable: true,
        rotateEnable: true,
        pitchEnable: true,
        zoom: 17,
        pitch: 80,
        rotation: -15,
        viewMode: '3D',//开启3D视图,默认为关闭
        buildingAnimation: true,//楼块出现是否带动画

        expandZoomRange: true,
        zooms: [3, 20],
        center: [116.403694,39.913385]
      });
      map.on('complete', function () {
        //添加地图插件  工具条、比例尺、鹰眼、地图类型、定位
        map.plugin(['AMap.ToolBar', 'AMap.Scale', 'AMap.OverView', 'AMap.MapType', 'AMap.Geolocation', 'AMap.ControlBar'], function () {
          //创建并添加工具控件,上下左右移动，以及缩放
          let scala = new AMap.Scale({offset: new AMap.Pixel(50, 35)});
          let toolBar = new AMap.ToolBar({ruler: false, noIpLocate: true, offset: new AMap.Pixel(10, 10)},);
          let geolocation = new AMap.Geolocation();
          let controlBar = new AMap.ControlBar({
            showZoomBar: false,
            showControlButton: true,
            position: {right: '10px', top: '10px'}
          });
          map.addControl(controlBar);
          map.addControl(scala);
          map.addControl(toolBar);
          map.addControl(geolocation);
        });
        $('.amap-locate').css('left', '0px');
        $('.amap-zoomcontrol').css('left', '0px');
        $('.amap-maptype-list p').css('width', '115px');
      });

      this.initActive(map);
    },
    initActive(map) {
      // 创建一个 Icon
      let myIcon = new AMap.Icon({
        // 图标尺寸
        size: new AMap.Size(16,16),
        // 图标的取图地址
        image: img,
        // 图标所用图片大小
        imageSize: new AMap.Size(16,16),
      });
      //创建右键菜单
      let contextMenu = new AMap.ContextMenu();
      //右键放大
      contextMenu.addItem("放大一级", function () {
        map.zoomIn();
      }, 0);
      //右键缩小
      contextMenu.addItem("缩小一级", function () {
        map.zoomOut();
      }, 1);
      //右键显示全国范围
      contextMenu.addItem("缩放至全国范围", function (e) {
        map.setZoomAndCenter(4, [108.946609, 34.262324]);
      }, 2);
      //地图绑定鼠标右击事件——弹出右键菜单
      map.on('rightclick', this.rightClick);
      this.menu = contextMenu;
      this.map = map;

      // 点击定位点的显示内容
      let infoWindow = new AMap.InfoWindow({offset: new AMap.Pixel(0, -30)});
      for (let i = 0, marker; i < this.Makes.length; i++) {
        // console.log(this.Makes[i])
        let marker = new AMap.Marker({
          position: [this.Makes[i].lng, this.Makes[i].lat],
          map: map,
          icon: myIcon,
        });
        let textDiv = document.createElement("div");
        textDiv.style.textAlign = "center";
        textDiv.style.fontSize = "14px";
        let markerSpan = document.createElement("span");
        markerSpan.innerHTML = "共 ";
        textDiv.appendChild(markerSpan);
        let markerSpan1 = document.createElement("span");
        markerSpan1.style.color = "#ff0000";
        markerSpan1.style.fontWeight = "bold";
        markerSpan1.innerHTML = this.Makes[i].count;
        textDiv.appendChild(markerSpan1);
        let markerSpan2 = document.createElement("span");
        markerSpan2.innerHTML = " 个房源";
        textDiv.appendChild(markerSpan2);
        textDiv.appendChild(document.createElement("br"));
        let markerSpan3_ = document.createElement("span");
        markerSpan3_.style.fontWeight = "bold";
        markerSpan3_.innerHTML = "小区名：";
        textDiv.appendChild(markerSpan3_);
        let markerSpan4_ = document.createElement("span");
        markerSpan4_.style.color = "#ff0000";
        markerSpan4_.style.fontWeight = "bold";
        markerSpan4_.innerHTML = this.Makes[i].community;
        textDiv.appendChild(markerSpan4_);
        textDiv.appendChild(document.createElement("br"));
        let markerSpan3 = document.createElement("span");
        markerSpan3.style.fontWeight = "bold";
        markerSpan3.innerHTML = "均价：";
        textDiv.appendChild(markerSpan3);
        let markerSpan4 = document.createElement("span");
        markerSpan4.style.color = "#ff0000";
        markerSpan4.style.fontWeight = "bold";
        markerSpan4.innerHTML = parseFloat(this.Makes[i].totalPrice).toFixed(3);
        textDiv.appendChild(markerSpan4);
        let markerSpan5 = document.createElement("span");
        markerSpan5.innerHTML = " 元/平米";
        textDiv.appendChild(markerSpan5);
        textDiv.appendChild(document.createElement("br"));
        let markerSpan6 = document.createElement("span");
        markerSpan6.style.fontWeight = "bold";
        markerSpan6.innerHTML = "地区：";
        textDiv.appendChild(markerSpan6);
        let markerSpan7 = document.createElement("span");
        markerSpan7.style.color = "#ff0000";
        markerSpan7.style.fontWeight = "bold";
        // markerSpan7.innerHTML = this.Makes[i].area.toFixed(3);
        markerSpan7.innerHTML = this.Makes[i].district;
        textDiv.appendChild(markerSpan7);
        let markerSpan8 = document.createElement("span");
        markerSpan8.innerHTML = " 区";
        textDiv.appendChild(markerSpan8);
        textDiv.appendChild(document.createElement("br"));
        let markerSpan9 = document.createElement("span");
        markerSpan9.style.fontWeight = "bold";
        markerSpan9.innerHTML = "建筑年代：";
        textDiv.appendChild(markerSpan9);
        let markerSpan10 = document.createElement("span");
        markerSpan10.innerHTML = this.Makes[i].year;
        textDiv.appendChild(markerSpan10);
        marker.content = textDiv;
        marker.on('click', markerClick);
        this.makes.push(marker);
        // marker.emit('click', {target: marker});
      }

      function markerClick(e) {
        infoWindow.setContent(e.target.content);
        infoWindow.open(map, e.target.getPosition());
      }

      // map.setFitView();
      // 测距 拉框缩放 画圆 画矩形
      let mouseTool = new AMap.MouseTool(map);
      this.mouseTool = mouseTool;

      map.on('zoomend', this.mapZoomend);
      // map.on('mousemove', this.showInfoMove);
    },
    addOverlays: function (e) {
      this.map.remove(this.overlays);
      this.overlays = [];
      this.overlays.push(e.obj);
      this.map.setFitView();
      let zoom = this.map.getZoom();
      for (let i = 0; i < this.makes.length; i++) {
        if (zoom > 9 && e.obj.contains(this.makes[i].getPosition())) {
          this.makes[i].show();
        } else {
          this.makes[i].hide();
        }
      }
    },
    mapZoomend1: function (e) {
      let zoom = this.map.getZoom();
      for (let i = 0; i < this.makes.length; i++) {
        if (zoom > 9 && this.overlays[0].contains(this.makes[i].getPosition())) {
          this.makes[i].show();
        } else {
          this.makes[i].hide();
        }
      }
    },
    circle() {
      this.circles += 1;
      if (this.circles % 2 === 1) {
        $('.control').find('li').each(function () {
          if ($(this).hasClass('active')) {
            $(this).click();
            $(this).removeClass('active')
          }
        });
        for (let i = 0; i < this.makes.length; i++) {
          this.makes[i].hide();
        }
        $('.circle').addClass('active');
        // this.map.off('mousemove', this.showInfoMove);
        this.map.off('zoomend', this.mapZoomend);
        this.map.on('zoomend', this.mapZoomend1);
        this.map.off('rightclick', this.rightClick);
        this.draw('circle');
        this.mouseTool.on('draw', this.addOverlays);
      } else {
        let zoom = this.map.getZoom();
        if (zoom > 9) {
          for (let i = 0; i < this.makes.length; i++) {
            this.makes[i].show();
          }
        }
        $('.circle').removeClass('active');
        this.map.off('zoomend', this.mapZoomend1);
        this.map.on('zoomend', this.mapZoomend);
        this.map.on('rightclick', this.rightClick);
        this.mouseTool.close(true); //关闭，并清除覆盖物
        this.mouseTool.off('draw', this.addOverlays);
      }
    },
  }
}
</script>

<style lang="scss" scoped>
  .documentation-container {
    margin: 10px;
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;
  }

  .importSearch {
    width: 100%;
    height: 100px;
    overflow: hidden;
    font-size: 15px;
  }

  .leftInput {
    margin-top: 0.5%;
    width: 89%;
    height: 100%;
    float: left;
  }

  .rightSubmit {
    width: 10%;
    height: 100%;
    float: left;
  }

  .InfoButton {
    display: none;
  }

  .btn-submit {
    width: 90%;
    float: right;
    height: 100%;
    line-height: 100px;
    font-size: 24px;
    color: #fff;
    /*writing-mode: tb-rl !important;*/
    text-align: center;
    border-radius: 2px;
    background-color: #00ac65;
    cursor: pointer;
  }

  .row1 {
    margin-top: 6px;
    padding-bottom: 0;
    margin-bottom: 0;
  }

  .row2 {
    margin-top: -5px;
  }

  .map {
    width: 100%;
    height: 800px;
    margin-top: 20px;
    margin-right: 17px;
    overflow: hidden;
    display: flex;
  }

  center{
    width: 100%;
    height: inherit;
  }

  #container {
    width: 100%;
    height: 100%;
    z-index: 0;
  }

  .control {
    position: absolute;
    z-index: 1;
    padding: 1px;
    margin-top: 24px;
    margin-left: 25%;
  }

  .control ul {
    list-style: none;
    margin: 0;
    padding: 0;
    width: auto;
  }

  .control ul li {
    box-shadow: rgba(0, 0, 0, 0.35) 2px 2px 3px;
    float: left;
    color: rgb(0, 0, 0);
    font-family: Arial, sans-serif;
    text-align: center;
    white-space: nowrap;
    border-radius: 3px;
    font-size: 15px;
    padding: 10px 15px;
    line-height: 1.3em;
    margin-right: 40px;
    border: 1px solid rgb(139, 164, 220);
    background-color: rgb(255, 255, 255);
  }

  .control ul li.active {
    cursor: pointer;
    background-color: rgb(142, 168, 224);
    border: 1px solid rgb(142, 168, 224);
    font-weight: bold;
    color: rgb(255, 255, 255);
  }

  .control ul li:hover {
    cursor: pointer;
  }
</style>
