import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/pages/index_page.dart';
import 'package:luggagemanagementsystem/pages/login_page.dart';

Handler rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

Handler indexHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IndexPage();
});
