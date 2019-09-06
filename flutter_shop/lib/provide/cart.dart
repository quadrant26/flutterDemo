import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";

  // 加入购物车
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    // 判断是否有值
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    // 循环判断是否有重复的
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item){
      // 有重复的
      if(item['goodsId'] == goodsId){
        tempList[ival]['count'] = item['count']+1;
        isHave = true;
      }
      ival++;
    });

    // 没有插入数据
    if(!isHave){
      tempList.add({
        'goodsId': goodsId, 
        'goodsName': goodsName, 
        'count': count, 
        'price': price, 
        'images': images
      });
    }

    // 数据静态化
    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  // 清空购物车
  remove () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    print('清空完成----------------------');
    notifyListeners();
  }
}