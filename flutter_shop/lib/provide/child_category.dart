import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引
  String maxParentId = '858'; // 默认大类id

  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id){
    // 点击大类清零
    childIndex = 0;
    maxParentId = id;
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
  changeChildIndex(index){
    childIndex = index;
    notifyListeners();
  }
}