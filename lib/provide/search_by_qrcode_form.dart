import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class SearchByQrcodeForm with ChangeNotifier {
  final searchByQrcodeFormKey = GlobalKey<FormState>();

  //  客户姓名
  String savername;

  //  日期
  String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  //  是否点击查找
  bool searchResult = false;

  setSaverName(value) {
    savername = value;
    notifyListeners();
  }

  setDate(value) {
    date = value;
    notifyListeners();
  }

  setSearchResult(value) {
    searchResult = value;
    notifyListeners();
  }
}
