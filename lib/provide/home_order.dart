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

  initHomeOrder() {
    hotelWeekOrder = 0;
    hotelTodayDeposit = 0;
    hotelTodayReceive = 0;
    clerkWeekOrder = 0;
    clerkTodayDeposit = 0;
    clerkTodayReceive = 0;
  }
}
