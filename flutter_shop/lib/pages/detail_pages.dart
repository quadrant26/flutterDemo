import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info.dart';
import './detail_page/detail_top_area.dart';

class DetailPage extends StatelessWidget {

  final String goodsId;

  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot){
          if( snapshot.hasData ){
            return Container(
              child: Column(
                children: <Widget>[
                  DetailTopArea(),
                ],
              ),
            );
          }else{
            return Text('加载中....');
          }
        }
      )
    );
  }

  _getBackInfo(BuildContext context) async{
    await Provide.value<DetailInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}