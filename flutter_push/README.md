# flutter_push

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 极光推送

- 导入包
 
    `jpush_flutter: 0.1.0`
    
- 配置极光推送key
    
    path: ./android/app/build.gradle
    
    ```
        android {
            ...
            
            defaultConfig {
                ...
                ndk {
                    //选择要添加的对应 cpu 类型的 .so 库。
                    abiFilters 'armeabi', 'armeabi-v7a', 'x86', 'x86_64', 'mips', 'mips64', 'arm64-v8a'
                }
            
                manifestPlaceholders = [
                    JPUSH_PKGNAME : "bundleId",
                    JPUSH_APPKEY : "key", // NOTE: JPush 上注册的包名对应的 Appkey.
                    JPUSH_CHANNEL : "developer-default", //暂时填写默认值即可.
                ]
                ...
            }
            ...
        }
    ```
    
- use
    
    `import 'package:jpush_flutter/jpush_flutter.dart';`
    
    ```
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
    
    ```
    
    ```
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
    ```
    