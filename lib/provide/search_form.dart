import 'package:flutter/material.dart';

class SearchForm with ChangeNotifier {
  final searchFormKey = GlobalKey<FormState>();

  //  搜索类型
  int searchType;

  //  搜索内容
  String searchMsg;

  //  显示的结果类型
  int showType;

  setSearchType(value) {
    searchType = value;
    notifyListeners();
  }

  setSearchMsg(value){
    searchMsg = value;
    notifyListeners();
  }

  setShowType(value){
    showType = value;
    notifyListeners();
  }

  initSearchForm() {
    searchType = null;
    showType = null;
  }
}
