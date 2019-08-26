import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引
  String maxParentId = '858'; // 默认大类id
  String subParentId = ''; // 小类ID 默认为空
  int page = 1; // 页码数
  String noMoreText = ''; // 显示没有数据的文字


  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id){
    // 点击大类清零
    childIndex = 0;
    maxParentId = id;
    page = 1;
    noMoreText = '';
    // 全部
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = "00";
    all.mallSubName = "全部";
    all.mallCategoryId = "00" ;
    all.comments = "null";
    childCategoryList = [all];
    childCategoryList.addAll(list);

    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id){
    // 初始化清零
    page = 1;
    noMoreText = '';
    childIndex = index;
    subParentId = id;
    notifyListeners();
  }

  // 增加page的方法
  addPage(){
    page ++;
  }

  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }
}