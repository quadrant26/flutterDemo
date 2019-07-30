import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController typeController = TextEditingController();
  String showText = '欢迎您来到天上人间高级会所';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('天上人间'),),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '美女类型',
                helperText: '请输入你喜欢的类型'
              ),
              autofocus: false,
            ),
            RaisedButton(
              onPressed: _choiceAction,
              child: Text('选择完毕')
            ),
            Text(
              showText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      )
    );
  }

  void _choiceAction (){
    print('开始选择您喜欢的类型.....');
    if ( typeController.text.toString() == ''){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('美女类型不能为空'))
      );
    }else{
      getHttp( typeController.text.toString() ).then( (val){
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String TypeText) async {
    try{
      Response response;
      var data = {'name': TypeText};
      response = await Dio().get('https://www.easy-mock.com/mock/5d3ec93ffd577d0215ccf756/flutterShop/dabaojian',
        queryParameters: data
      );
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}