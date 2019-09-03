import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var goodsDetails = Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodsDesc;
    return Container(
      child: Html(
        data: goodsDetails
      )
    );
  }
}