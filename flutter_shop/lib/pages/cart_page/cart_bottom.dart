import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Provide<CartProvide>(
        builder: (context, child, childCart){
          return Row(
            children: <Widget>[
              _selectAllButton(context),
              _allPriceArea(context),
              _goButton(context)
            ],
          );
        },
      )
    );
  }


  // 全选按钮
  Widget _selectAllButton (context){
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              Provide.value<CartProvide>(context).changeAllCheckButtonState(val);
            },
          ),
          Text(
            '全选',
            style: TextStyle(color: Colors.black)
          )
        ],
      )
    );
  }

  // 合计
  Widget _allPriceArea(context){
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(250),
                child: Text(
                  '合计',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36))
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(180),
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(36))
                )
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(28),
              )
            )
          ),
        ],
      )
    );
  }

  // 结算按钮
  Widget _goButton(context){
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white
            )
          ),
        )
      )
    );
  }
}