import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类')),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        )
      )
    );
  }
}

// 左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsListId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return _leftInkWell(index);
        },
      ),
    );
  }

  // 单独的子项
  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (index==listIndex) ? true : false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        // provide 改变
        var childList = list[index].bxMallSubDto;
        var maxParentId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList, maxParentId);
        _getGoodsListId(maxParentId: maxParentId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top:15),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(246,246,246,1.0) : Colors.white, // 颜色调整
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      )
    );
  }

  void _getCategory() async {
    var formData = {"act": "category"};
      
    await request('getCategory', formData: formData).then( (val){  
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });

      // 设置默认加载第一项内容
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  // 右侧大类商品列表
  void _getGoodsListId({String maxParentId}) async {
    var data = {
      'maxParentId': maxParentId == null ? '858' : maxParentId,
      'subParentId': '',
      'page': 1
    };

    // 获取category商品列表
    await request('getCategoryList', formData: data).then( (val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  // List list = ['名酒', '宝丰', '北京二锅头', '舍得', '茅台', '五粮液', '江小白', '洋河蓝色经典', '郎酒'];

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory){
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width:1.0, color: Colors.black12),
            )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index){
              return _rightInkWell(index, childCategory.childCategoryList[index]);
            },
          )
        );
      },
    );
  }

  Widget _rightInkWell (int index, BxMallSubDto item){
    bool isClick = false;
    // 和 Provide 进行对比 判断是否显示高亮状态
    isClick = (index==Provide.value<ChildCategory>(context).childIndex) ? true : false;
    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        _getGoodsListId(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28), 
            color: isClick ? Colors.pink : Colors.black
          ),
        ),
      )
    );
  }

  // 右侧小类商品列表
  void _getGoodsListId(String subParentId) async {
    var data = {
      'maxParentId': Provide.value<ChildCategory>(context).maxParentId,
      'subParentId': subParentId,
      'page': 1
    };

    // 获取category商品列表
    await request('getCategoryList', formData: data).then( (val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if( goodsList.data == null){
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      }
    });
  }
}

// 商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data){
        if (data.goodsList.length > 0){
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: ListView.builder(
                itemCount: data.goodsList.length,
                itemBuilder: (context, index){
                  return _listWidget(data.goodsList, index);
                }
              )
            ),
          );
        }else{
          return Text('暂时没有数据...');
        }
      }
    ); 
    
  }

  Widget _goodsImage (List newList, index){
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Image.network("http://sun.siriusalpha.cn/"+newList[index].goodsImg),
    );
  }

  Widget _goodsName(List newList, index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(400),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28),),
      )
    );
  }

  Widget _goodsPrice (List newList, index){
    return Container(
      margin: EdgeInsets.only(top: 5.0, left: 5.0),
      width: ScreenUtil().setWidth(400),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ￥${newList[index].shopPrice}',
            style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.pink)
          ),
          Text(
            '￥${newList[index].marketPrice}',
            style: TextStyle(fontSize: ScreenUtil().setSp(24), color: Colors.black26, decoration: TextDecoration.lineThrough)
          ),
        ]
      ),
    );
  }

  Widget _listWidget(List newList, int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ]
            )
          ]
        )
      )
    );
  }
}