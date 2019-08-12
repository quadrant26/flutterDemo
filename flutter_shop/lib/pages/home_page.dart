import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_method.dart';
import 'dart:convert';

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
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDateList: swiper,)
              ]
            );
          }else{
            return Center(
              child: Text('加载中...')
            );
          }
        },
      )
    );
  }
}

/**
 * 首页轮播组件
 */
class SwiperDiy extends StatelessWidget {

  final List swiperDateList;
  SwiperDiy({this.swiperDateList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
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