import 'package:flutter/material.dart';

class HomeOrder with ChangeNotifier {
  int hotelWeekOrder = 0;
  int hotelTodayDeposit = 0;
  int hotelTodayReceive = 0;
  int clerkWeekOrder = 0;
  int clerkTodayDeposit = 0;
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
}
