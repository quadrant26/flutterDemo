import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求数据';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('获取远程数据'),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _geek,
              child: Text('请求数据')
            ),
            Text(showText)
          ],
        )
      )
    );
  }

  void _geek(){
    print('开始向极客时间请求数据.......');
    getHttp().then( (val){
      setState(() {
        showText = val['data'].toString();
      });
    });
  }

  Future getHttp() async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response = await dio.post('https://time.geekbang.org/serv/v1/column/newAll',
        queryParameters: {}
      );
      return response;
    }catch(e){
      return print(e);
    }
  }
}