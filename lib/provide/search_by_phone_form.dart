import 'package:flutter/material.dart';

class SearchByPhoneForm with ChangeNotifier {
  final searchByPhoneFormKey = GlobalKey<FormState>();

  //  手机号
  String phone;

  //  按钮是否已点击
  bool isDisabled = false;
  
  setPhone(value){
    phone = value;
    notifyListeners();
  }
  
  setIsDisabled(value){
    isDisabled = value;
    notifyListeners();
  }
}
