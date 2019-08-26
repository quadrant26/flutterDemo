import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
/**
 * 保持页面状态
 * 1. 混入 AutomaticKeepAliveClientMixin
 *  with AutomaticKeepAliveClientMixin
 * 2. 重写方法
 *  @override
 *  bool get wantKeepAlive => true;
 * 3. 改造index_page.dart
 * 其中 tabBodies 重新定义为 List <Widget> tabBodies
 *  body: IndexedStack(
 *   index: currentPage,
 *   children: tabBodies,
 *  )
 */
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  int page = 1;
  List<Map> hotGoodsListBelow = [];

  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // getHomePageContent().then( (val){
    //   setState(() {
    //    homePageContent = val.toString(); 
    //   });
    // });
    super.initState();
    _getHotGoodsBelow();
  }
  
  String homePageContent = '正在获取数据...';

  @override
  Widget build(BuildContext context) {
   var formData = {
      'lon': '115.02932',
      'lat': '35.76189',
      'act': 'index'
    };
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+')),
      body: FutureBuilder(
        future: request('homePageContent', formData: formData),
        builder: (context, snapshot){
          if ( snapshot.hasData ){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['banner'] as List).cast();
            List<Map> navigatorList = (data['data']['subnav'] as List).cast();
            String adPicture = data['data']['adv_click_index'];
            String leaderImage = data['data']['cellmoile']['icon'];
            String leaderPhone = data['data']['cellmoile']['phone'];
            List<Map> recommendList = (data['data']['hotgoods'] as List).cast();
            String floorTitle = data['data']['floor']['titleImg'];
            List<Map> flootGoodsList = (data['data']['floor']['youLike'] as List).cast();
            // print(flootGoodsList);

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerkey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText: '上拉加载'
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDateList: swiper),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPicture),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommend(recommendList: recommendList),
                  FloorTitle(picture_address: floorTitle),
                  FloorContent(floorGoodsList: flootGoodsList),
                  _hotGoods(),
                ]
              ),
              loadMore: ()async {
                print('开始加载更多.....');
                var formData = {"page": page, "act": 'hotbelow'};
                await request('homePageBelowContent', formData: formData).then( (val){
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data']['list'] as List).cast();
                  setState( (){
                    hotGoodsListBelow.addAll(newGoodsList);
                    page++;
                  });
                });
              }
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

  // 获取火爆专区商品
  void _getHotGoodsBelow (){
    var formData = {"page": page, "act": 'hotbelow'};
    request('homePageBelowContent', formData: formData).then( (val){
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data']['list'] as List).cast();
      setState( (){
        hotGoodsListBelow.addAll(newGoodsList);
      });
    });
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border:Border(
        bottom: BorderSide(width:0.5 ,color:Colors.black12)
      )
    ),
    child: Text('火爆专区')
  );

  Widget _wrapList (){
    if ( hotGoodsListBelow.length != 0 ){
      List<Widget> listWidget = hotGoodsListBelow.map( (val){
        return InkWell(
          onTap: (){},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network( val['img'], width: ScreenUtil().setWidth(370) ),
                Text(
                  val['goods_name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['org_price']}'),
                    Text(
                      '￥${val['marketPrice']}',
                      style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
                    )
                  ]
                ),
              ]
            ),
          )
        );
      }).toList();

      // 返回流式布局
      return Wrap(
        spacing: 2,
        children: listWidget
      );
    }else{
      return Text("没有获取到数据");
    }
  }

  Widget _hotGoods (){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList()
        ]
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
        physics: NeverScrollableScrollPhysics(),
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
class AdBanner extends StatelessWidget {

  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture)
    );
  }
}

// 首页点击图片拨打电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 图片
  final String leaderPhone; // 电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL () async {
    // 拨打电话
    String url = 'tel:' + leaderPhone;
    // 跳转到页面
    // String url = 'http://www.baidu.com/';
    if ( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'url 不能进行访问';
    }
  }
}

// 商品推荐类
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  // 商品的标题
  Widget _titleWidget (){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color:Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐', 
        style: TextStyle(color: Colors.pink)
      )
    );
  }

  // 商品单独项
  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['img']),
            Text('￥${recommendList[index]['marketPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              )
            )
          ],
        ),
      )
    );
  }

  // 横向列表
  Widget _recommendList (){
    return Container(
      height: ScreenUtil().setHeight(350),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index){
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(410),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ]
      ),
    );
  }
}

// 楼层商品标题 图片
class FloorTitle extends StatelessWidget {
  final String picture_address;

  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address)
    );
  }
}

class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherItem()
        ],
      ),
    );
  }

  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0], 300),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1], 150),
            _goodsItem(floorGoodsList[2], 150),
          ],
        )
      ],
    );
  }

  Widget _otherItem(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3], 200.0),
        _goodsItem(floorGoodsList[4], 200.0),
      ],
    );
  }

  Widget _goodsItem(Map Goods, double height){
    return Container(
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setWidth(height),
      decoration: BoxDecoration(
        border: new Border.all(color: Colors.black12, width: 0.5),
      ),
      child: InkWell(
        onTap: (){print('点击楼层商品');},
        child: Image.network(Goods['img'])
      )
    );
  }
}

// 获取火热推荐
class HotGoods extends StatefulWidget {
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {

  @override
  void initState() { 
    super.initState();
    int page = 1;
    var formData = {
      'act': 'hotbelow',
      'page': page
    };
    request('homePageBelowContent', formData: formData).then( (val){
      print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('kang'),
    );
  }
}