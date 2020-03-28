import 'package:flutter/material.dart';

class ForgetForm with ChangeNotifier {
  final forgetFormKey = GlobalKey<FormState>();

  //  手机号
  String phone;

  //  验证码
  String checkNumber;

  //  是否已发送验证码
  bool isSend = false;

  //  登陆按钮是否已点击
  bool isDisabled = false;

  //  倒计时
  int seconds;

  setPhone(value) {
    phone = value;
    notifyListeners();
  }

  setCheckNumber(value) {
    checkNumber = value;
    notifyListeners();
  }

  changeIsSend(value) {
    isSend = value;
    notifyListeners();
  }

  changeIsDisabled(value){
    isDisabled = value;
    notifyListeners();
  }

  setSeconds(value) {
    seconds = value;
    notifyListeners();
  }

  clearForgetForm() {
    phone = null;
    checkNumber = null;
    isSend = false;
    isDisabled = false;
    seconds = null;
  }
}
