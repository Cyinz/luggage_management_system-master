import 'package:flutter/material.dart';

class CheckUpdate with ChangeNotifier{
  int count = 0;
  int total = 100;

  setCount(value){
    count = value;
    notifyListeners();
  }

  setTotal(value){
    total = value;
    notifyListeners();
  }
}