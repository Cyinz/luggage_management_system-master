import 'package:flutter/material.dart';

class ResetForm with ChangeNotifier {
  final resetFormKey = GlobalKey<FormState>();

  //  登录账号
  String userLoginName;

  //  原密码
  String password;

  //  新密码
  String newPassword;

  //  修改按钮是否被禁用
  bool isDisabled = false;

  setUserLoginName(value){
    userLoginName = value;
    notifyListeners();
  }

  setPassword(value){
    password = value;
    notifyListeners();
  }

  setNewPassword(value){
    newPassword = value;
    notifyListeners();
  }

  setIsDisabled(value){
    isDisabled = value;
    notifyListeners();
  }
}
