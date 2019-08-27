import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routers {
  static String root = '/';
  static String detailPage = '/detail';
  static void configureRouters(Router router){
    // 找不到路由或路径
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('Error: Route was not found!!!');
      }
    );

    router.define(detailPage, handler: detailHandler);
  }
}
