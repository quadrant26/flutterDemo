import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      )
    );
  }

  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20.0),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(200),
            decoration: BoxDecoration(
              color: Colors.pink,
              border: Border.all(width:2, color: Colors.white),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: ClipOval(
              child: Image.network('https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2242193619,2136427601&fm=85&app=63&f=PNG?w=121&h=75&s=9631728613A4B14B02CB6FAE0300700A')
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              'kang',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Colors.black54,
              )
            )
          ),
        ],
      )
    );
  }

  // 我的订单
  Widget _orderTitle (){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width:1, color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      )
    );
  }

  // 小导航
  Widget _orderType(){
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(170),
      padding: EdgeInsets.only(top:15.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30
                ),
                Text('代付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30
                ),
                Text('代发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30
                ),
                Text('代收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30
                ),
                Text('代评价')
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 通用 ListTile
  Widget _myListTile (String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.credit_card),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      )
    );
  }

  // 组合
  Widget _actionList (){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('联系客服'),
          _myListTile('关于我们'),
        ],
      )
    );
  }
}