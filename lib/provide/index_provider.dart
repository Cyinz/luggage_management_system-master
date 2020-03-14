import 'package:flutter/material.dart';

class DepositProvider with ChangeNotifier {
  //  定义当前页面
  int currentIndex = 0;

  //  改变当前页面
  indexChange(value) {
    currentIndex = value;
    notifyListeners();
  }
}
