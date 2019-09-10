import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  double allPrice = 0;   // 总价格
  int allGoodsCount = 0; // 商品总数量
  bool isAllCheck = true; // 是否全选

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
      // 计算
      // 初始化
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;

      tempList.forEach((item){
        // 获取价格和总价
        if ( item['isCheck']){
          allPrice += (item['count']*double.parse(item['price']));
          allGoodsCount += item['count'];
        }else{
          isAllCheck = false;
        }
        cartList.add(new CartInfoModel.fromJson(item));
        
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
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 单项商品的选择操作
  changeCheckState(CartInfoModel cartItem) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex=0;
    int changeIndex=0;

    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  // 购物车底部全选按钮操作
  changeAllCheckButtonState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];

    // dart 不允许改变老旧的值
    for(var item in tempList){
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  
  // 商品数量加减
  addOrReduceAction(var cartItem, String todo) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if( item['goodsId'] == cartItem.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex ++;
    });

    if( todo == 'add' ){
      cartItem.count++;
    }else if(cartItem.count > 1){
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }
}