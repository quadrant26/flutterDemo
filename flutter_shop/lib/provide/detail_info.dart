import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailModel goodsInfo;
  
  bool isLeft = true;
  bool isRight = false;

  // tabbar 的切换方法
  changeLeftAndRight(String changeState){
    if( changeState == 'left'){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }

    notifyListeners();
  }

  // 从后台获取商品数据
  getGoodsInfo (String id) async {
    var formData = {
      "goods_id": id
    };

    await request('getGoodsInfoById', formData: formData).then( (val){
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = DetailModel.fromJson(responseData);
      notifyListeners();
    });
  }
}