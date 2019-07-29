import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      appBar: AppBar(title: Text('首页')),
      body: Center(child: Text('首页'),)
    );
  }
}

void getHttp() async{
  try{
    Response response;
    response = await Dio().get('https://www.easy-mock.com/mock/5d3ec93ffd577d0215ccf756/flutterShop/dabaojian');
    return print(response);
  }catch(e){
    return print(e);
  }
}