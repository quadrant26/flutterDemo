import 'package:flutter/material.dart';
import './pages/index_page.dart';

void mian() => runApp(MyApp());

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