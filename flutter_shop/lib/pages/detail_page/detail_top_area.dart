import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvide>(
      builder: (context, child, val){
        var goodsInfo = Provide.value<DetailInfoProvide>(context).goodsInfo.data;
        if( goodsInfo != null){
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.goodsImg),
                _goodsName(goodsInfo.goodsName),
                _goodsNumber(goodsInfo.goodsNumber),
                _goodsPrice(goodsInfo.shopPrice, goodsInfo.marketPrice)
              ],
            ),
          );
        }else{
          return Text('正在加载中....');
        }
      }
    );
  }

  // 商品图片地址
  Widget _goodsImage(url){
    return Image.network(
      'http://sun.siriusalpha.cn/' + url,
      width: ScreenUtil().setWidth(740)
    );
  }

  // 商品名称
  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(32),
          color: Colors.black,
        )
      )
    );
  }

  // 商品编号
  Widget _goodsNumber(number){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        '商品编号： ${number}',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
          color: Colors.black87
        ),
      )
    );
  }

  // 商品价格
  Widget _goodsPrice(shopPrice, marketPrice){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${shopPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Colors.pink
            )
          ),
          Text(
            '市场价：￥${marketPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            )
          ),
        ],
      ),
    );
  }
}