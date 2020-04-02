import 'package:flutter/material.dart';

class HomeOrder with ChangeNotifier {
  //  酒店一周订单总数
  int hotelWeekOrder = 0;

  //  酒店当天寄存数
  int hotelTodayDeposit = 0;

  //  酒店当天领取数
  int hotelTodayReceive = 0;

  //  行李员一周订单总数
  int clerkWeekOrder = 0;

  //  行李员当天寄存数
  int clerkTodayDeposit = 0;

  //  行李员当天领取数
  int clerkTodayReceive = 0;

  //  行李员历史订单
  List<Map> clerkHistoryOrder = [];

  //  客户姓名
  var saverName = [];

  //  客户电话
  var saverPhone = [];

  //  行李图片
  var luggagePic = [];

  setHotelWeekOrder(value) {
    hotelWeekOrder = value;
    notifyListeners();
  }

  setHotelTodayDeposit(value) {
    hotelTodayDeposit = value;
    notifyListeners();
  }

  setHotelTodayReceive(value) {
    hotelTodayReceive = value;
    notifyListeners();
  }

  setClerkWeekOrder(value) {
    clerkWeekOrder = value;
    notifyListeners();
  }

  setClerkTodayDeposit(value) {
    clerkTodayDeposit = value;
    notifyListeners();
  }

  setClerkTodayReceive(value) {
    clerkTodayReceive = value;
    notifyListeners();
  }

  //  添加历史订单列表
  addOrderList(value) {
    clerkHistoryOrder.addAll(value);
    notifyListeners();
  }

  //  添加客户姓名
  addSaverName(value){
    saverName.add(value);
    notifyListeners();
  }

  //  添加客户电话
  addSaverPhone(value){
    saverPhone.add(value);
    notifyListeners();
  }

  //  添加行李图片
  addLuggagePic(value){
    luggagePic.add(value);
    notifyListeners();
  }

  initHomeOrder() {
    hotelWeekOrder = 0;
    hotelTodayDeposit = 0;
    hotelTodayReceive = 0;
    clerkWeekOrder = 0;
    clerkTodayDeposit = 0;
    clerkTodayReceive = 0;
    clerkHistoryOrder = [];
    saverName = [];
    saverPhone = [];
    luggagePic = [];
  }
}
