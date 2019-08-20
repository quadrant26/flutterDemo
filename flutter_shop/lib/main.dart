import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';

void main() {
  var counter = Count();
  var providers = Providers();

  providers..provide(Provider<Count>.value(counter));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false, //去掉右上角 debug logo
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage()
      )
    );
  }
}