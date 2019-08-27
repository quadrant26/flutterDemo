import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info.dart';

class DetailPage extends StatelessWidget {

  final String goodsId;

  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Container(
      child: Center(
        child: Text('商品ID为： ${this.goodsId}'),
      )
    );
  }

  void _getBackInfo(BuildContext context) async{
    await Provide.value<DetailInfoProvide>(context).getGoodsInfo(goodsId);
    print("加载完成........");
  }
}