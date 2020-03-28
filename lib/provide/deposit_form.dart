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
  String storeToTime = formatDate(
      DateTime.now(), [yyyy, '-', mm, '-', dd, " ", HH, ":", nn, ":", ss]);

  //  行李件数
  int number;

  //  行李图片
  File pic;

  //行李备注
  String desc;

  //  寄存按钮是否被禁用
  bool isDisabled = false;

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

  setNumber(value) {
    number = value;
    notifyListeners();
  }

  setPic(value) {
    pic = value;
    notifyListeners();
  }

  setDesc(value) {
    desc = value;
    notifyListeners();
  }

  //  改变寄存按钮是否被禁用状态
  isDisabledChange() {
    isDisabled = !isDisabled;
    notifyListeners();
  }

  //  清空表单保存的内容，初始化寄存表单
  clearDepositForm() {
    savername = null;
    phone = null;
    tag = null;
    location = null;
    gender = 1;
    storeToTime = formatDate(
        DateTime.now(), [yyyy, '-', mm, '-', dd, " ", HH, ":", nn, ":", ss]);
    number = null;
    pic = null;
    isDisabled = false;
  }
}
