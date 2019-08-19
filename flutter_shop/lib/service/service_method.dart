import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页内容数据
Future getHomePageContent () async {

  try{
    print("开始获取首页数据...");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");

    var formData = {
      'lon': '115.02932',
      'lat': '35.76189',
      'act': 'index'
    };

    print( servicePath['homePageContent'] );
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if ( response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常');
    }
  }catch (e){
    return print('ERROR: ----->${e}');
  }

}

// 获取首页热卖商品
Future getHomePageBelowContent () async {

  try{
    print("开始获取首页热卖商品数据...");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");

    int page = 1;
    var formData = {
      'act': 'hotbelow',
      'page': page
    };

    print( servicePath['homePageBelowContent'] );
    response = await dio.post(servicePath['homePageBelowContent'], data: formData);
    if ( response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常');
    }
  }catch (e){
    return print('ERROR: ----->${e}');
  }
  
}

Future request (url, {formData}) async {

  try{
    print("开始获取数据...");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if ( formData == null){
      response = await dio.get(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url], data: formData);
    }

    
    if ( response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常');
    }
  }catch (e){
    return print('ERROR: ----->${e}');
  }

}