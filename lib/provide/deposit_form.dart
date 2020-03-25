import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class DepositForm with ChangeNotifier {
  final depositFormKey = GlobalKey<FormState>();

  //  客户姓名
  String savername;

  //  客户手机号
  String phone;

  //  行李标签号
  String tag;

  //  行李位置
  String location;

  //  客户性别
  int gender = 1;

  // 行李预计领取时间
  String storeToTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  //  行李图片
  File pic;

  setSaverName(value) {
    savername = value;
    notifyListeners();
  }

  setPhone(value) {
    phone = value;
    notifyListeners();
  }

  setTag(value) {
    tag = value;
    notifyListeners();
  }

  setLocation(value) {
    location = value;
    notifyListeners();
  }

  setGender(value) {
    gender = value;
    notifyListeners();
  }

  setStoreToTime(value) {
    storeToTime = value;
    notifyListeners();
  }

  setPic(value){
    pic = value;
    notifyListeners();
  }

  clear(){
    pic = null;
  }
}
