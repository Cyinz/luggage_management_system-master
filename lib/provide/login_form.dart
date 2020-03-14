import 'package:flutter/material.dart';

class LoginForm with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();

  //  登陆账号
  String username;

  //  登陆密码
  String password;

  //  是否隐藏密码
  bool isObscure = true;

  //  改变隐藏密码小眼睛图标颜色
  Color eyeColor = Colors.grey;

  //  登陆按钮是否被禁用
  bool isDisabled = false;

  saveUserName(value) {
    username = value;
    notifyListeners();
  }

  savePassword(value) {
    password = value;
    notifyListeners();
  }

  //  改变是否隐藏密码状态
  isObscureChange() {
    isObscure = !isObscure;
    eyeColor = isObscure ? Colors.grey : Colors.blue;
    notifyListeners();
  }

  //  改变登陆按钮是否被禁用状态
  isDisabledChange() {
    isDisabled = !isDisabled;
    notifyListeners();
  }
}
