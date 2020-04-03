import 'dart:io';
import 'package:flutter/material.dart';

class UpdateForm with ChangeNotifier {
  final updateFormKey = GlobalKey<FormState>();

  //  姓名
  String username;

  //  登录账号
  String userLoginName;

  //  权限
  int right;

  //  头像
  File image;

  //  酒店
  String hotel;

  //  工号
  String id;

  //  账号使用状态
  int state;

  //  手机号
  String phone;

  //  修改按钮是否被禁用
  bool isDisabled = false;

  setUsername(value) {
    username = value;
    notifyListeners();
  }

  setUserLoginName(value) {
    userLoginName = value;
    notifyListeners();
  }

  setRight(value) {
    right = value;
    notifyListeners();
  }

  setImage(value) {
    image = value;
    notifyListeners();
  }

  setHotel(value) {
    hotel = value;
    notifyListeners();
  }

  setId(value) {
    id = value;
    notifyListeners();
  }

  setState(value) {
    state = value;
    notifyListeners();
  }

  setPhone(value) {
    phone = value;
    notifyListeners();
  }

  setIsDisabled(value) {
    isDisabled = value;
    notifyListeners();
  }
}
