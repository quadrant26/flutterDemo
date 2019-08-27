import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailModel goodsInfo;

  // 从后台获取商品数据
  getGoodsInfo (String id){
    var formData = {
      "goods_id": id
    };

    request('getGoodsInfoById', formData: formData).then( (val){
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = DetailModel.fromJson(responseData);
      notifyListeners();
    });
  }
}