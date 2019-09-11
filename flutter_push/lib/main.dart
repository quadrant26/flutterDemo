import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{

  String debugLable = 'Unknown';
  final JPush jPush = new JPush();

  @override
  void initState(){
    super.initState();
    initPlatformState();  //极光插件平台初始化
  }

  Future<void> initPlatformState () async {
    String platformVersion;

    try{
      jPush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async{
            print('>>>>>>>>>>>> flutter 接收到极光推送： ${message}');
            setState(() {
              debugLable = '接收到推送：${message}';
            });
          }
      );
    } on PlatformException {
      platformVersion = "平台版本获取失败，请检查";
    }

    if( !mounted ) return;
    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('极光推送'),
        ),
        body: new Center(
            child: new Column(
                children:[
                  new Text('结果: $debugLable\n'),
                  new FlatButton(
                      child: new Text('发送推送消息\n'),
                      onPressed: () {
                        // 三秒后发出本地推送
                        var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3000);
                        var localNotification = LocalNotification(
                          id: 234,
                          title: '飞信',
                          buildId: 1,
                          content: '看到了说明已经成功了',
                          fireTime: fireDate,
                          subtitle: '一个测试',
                        );
                        jPush.sendLocalNotification(localNotification).then((res) {
                          setState(() {
                            debugLable = res;
                          });
                        });

                      }),

                ]
            )

        ),
      ),
    );
  }
}
