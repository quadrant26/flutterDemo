import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartCount extends StatelessWidget {

  var item;
  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          _reduceButton(context),
          _countArea(),
          _addButton(context),
        ],
      )
    );
  }

  // 左边减号
  Widget _reduceButton (context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count>1?Colors.white:Colors.black12,
          border: Border(
            right: BorderSide(width:1.0, color: Colors.black12),
          )
        ),
        child: item.count>1?Text('-'):Text('.')
      )
    );
  }

  // 右边加号
  Widget _addButton (context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width:1.0, color: Colors.black12),
          )
        ),
        child: Text(
          '+'
        )
      )
    );
  }

  // 中间数字显示区域
  Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}')
    );
  }
}