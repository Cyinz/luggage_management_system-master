import 'package:flutter/material.dart';

class ReceiveForm with ChangeNotifier {
  final receiveFormKey = GlobalKey<FormState>();

  //  取行李码
  String getNumber;

  setGetNumber(value) {
    getNumber = value;
    notifyListeners();
  }
}
