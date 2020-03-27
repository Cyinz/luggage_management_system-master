import 'package:flutter/material.dart';

class ReceiveForm with ChangeNotifier {
  String qrcodeMsg;

  setQrcodeMsg(value) {
    qrcodeMsg = value;
    notifyListeners();
  }
}
