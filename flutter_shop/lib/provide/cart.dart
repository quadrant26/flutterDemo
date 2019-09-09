import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];

  // 加入购物车
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    // 判断是否有值
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    print(temp);
    
    // 循环判断是否有重复的
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item){
      // 有重复的
      if(item['goodsId'] == goodsId){
        tempList[ival]['count'] = item['count']+1;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    // 没有插入数据
    if(!isHave){
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId, 
        'goodsName': goodsName, 
        'count': count, 
        'price': price, 
        'images': images,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    // 数据静态化
    cartString = json.encode(tempList).toString();
    // print('字符串>>>>>>>>${cartString}');
    // print('数据模型>>>>>>>>>>>>>>>${cartList}');
    prefs.setString('cartInfo', cartString);
    
    notifyListeners();
  }

  // 清空购物车
  remove () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    print('清空完成----------------------');
    notifyListeners();
  }

  getCartInfo () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if ( cartString == null){
      cartList = [];
    }else{
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item){
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  // 删除单个商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex=0;
    int delIndex=0;

    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cartString = json.encode(tempList);
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}