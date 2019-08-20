import 'package:flutter/material.dart';

class Count with ChangeNotifier {
  int value = 0;
  
  increment (){
    value ++;
    notifyListeners();
  }
}