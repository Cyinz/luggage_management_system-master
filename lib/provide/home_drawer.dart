import 'package:flutter/material.dart';

class HomeDrawer with ChangeNotifier {
  String clerkId;
  String clerkName;
  String clerkImg;
  String clerkHotel;

  setClerkId(value) {
    clerkId = value;
    notifyListeners();
  }

  setClerkName(value) {
    clerkName = value;
    notifyListeners();
  }

  setClerkImg(value) {
    clerkImg = value;
    notifyListeners();
  }

  setClerkHotel(value) {
    clerkHotel = value;
    notifyListeners();
  }
}
