import 'package:flutter/material.dart';

class ReceiveForm with ChangeNotifier {
  final receiveFormKey = GlobalKey<FormState>();

  //  取行李码
  String getNumber;

  //  客户姓名
  String savername;

  //  客户电话
  String phonenumber;

  //  客户性别
  String saverGender;

  //  行李描述
  String describe;

  //  行李标签
  String tag;

  //  行李位置
  String location;

  //  行李件数
  int number;

  //  存放时间
  String savetime;

  //  预计领取时间
  String storeToTime;

  //  领取时间
  String gettime;

  //  行李领取状态
  int isReceive;

  //  寄存行李员姓名
  String receivername;

  //  行李图片路径
  String picture;

  //  是否搜索成功
  bool isSerach = false;

  setGetNumber(value) {
    getNumber = value;
    notifyListeners();
  }

  setSaverName(value) {
    savername = value;
    notifyListeners();
  }

  setSaverGender(value) {
    saverGender = value;
    notifyListeners();
  }

  setPhoneNumber(value) {
    phonenumber = value;
    notifyListeners();
  }

  setDescribe(value) {
    describe = value;
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

  setNumber(value) {
    number = value;
    notifyListeners();
  }

  setSaveTime(value) {
    savetime = value;
    notifyListeners();
  }

  setStoreToTime(value) {
    storeToTime = value;
    notifyListeners();
  }

  setGetTime(value) {
    gettime = value;
    notifyListeners();
  }

  setIsReceive(value) {
    isReceive = value;
    notifyListeners();
  }

  setReceiverName(value) {
    receivername = value;
    notifyListeners();
  }

  setPicture(value) {
    picture = value;
    notifyListeners();
  }

  changeIsSearch(value) {
    isSerach = value;
    notifyListeners();
  }

  //  清空表单保存的内容，初始化领取表单
  clearReceiveForm() {
    getNumber = null;
    savername = null;
    phonenumber = null;
    saverGender = null;
    describe = null;
    tag = null;
    location = null;
    number = null;
    savetime = null;
    storeToTime = null;
    gettime = null;
    isReceive = null;
    receivername = null;
    picture = null;
    isSerach = false;
  }
}
