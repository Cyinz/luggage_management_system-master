import 'package:flutter/material.dart';

class MeForm with ChangeNotifier {
  final meFormKey = GlobalKey<FormState>();

  //  用户ID
  String id = "";

  //  用户名
  String username = "";

  //用户头像
  String img = "";

  //  用户权限
  int right;

  //  用户所在酒店
  String hotel = "";

  //  用户登陆状态
  int state;

  //  用户电话
  String phonenumber = "";

  setId(value) {
    id = value;
    notifyListeners();
  }

  setUsername(value) {
    username = value;
    notifyListeners();
  }

  setImg(value) {
    img = value;
    notifyListeners();
  }

  setRight(value) {
    right = value;
    notifyListeners();
  }

  setHotel(value) {
    hotel = value;
    notifyListeners();
  }

  setState(value) {
    state = value;
    notifyListeners();
  }

  setPhone(value) {
    phonenumber = value;
    notifyListeners();
  }
}
