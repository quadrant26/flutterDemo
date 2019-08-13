import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据...';

  // @override
  // void initState() {
  //   getHomePageContent().then( (val){
  //     setState(() {
  //      homePageContent = val.toString(); 
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+')),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot){
          if ( snapshot.hasData ){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['banner'] as List).cast();
            List<Map> navigatorList = (data['data']['subnav'] as List).cast();

            return Column(
              children: <Widget>[
                SwiperDiy(swiperDateList: swiper),
                TopNavigator(navigatorList: navigatorList),
              ]
            );
          }else{
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      )
    );
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {

  final List swiperDateList;
  SwiperDiy({this.swiperDateList});

  @override
  Widget build(BuildContext context) {

    // 设备的像素密度 高 宽
    // print("设备的像素密度: ${ScreenUtil.pixelRatio}");
    // print("设备的高: ${ScreenUtil.screenHeight}");
    // print("设备的宽: ${ScreenUtil.screenWidth}");

    return Container(
      height: ScreenUtil().setHeight(420),
      width: ScreenUtil().setWidth(1242),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Image.network("${swiperDateList[index]['imgUrl']}", fit: BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 首页小导航
class TopNavigator extends StatelessWidget {

  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item){
    return InkWell(
      onTap: (){print('点击了导航');},
      child: Column(
        children: <Widget>[
          Image.network(item['img'], width: ScreenUtil().setWidth(95) ),
          Text(item['title'])
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // 如果列表超过10个则删除之后的
    if ( this.navigatorList.length > 10){
      this.navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(360),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map( (item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// 首页广告条