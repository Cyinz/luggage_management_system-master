import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/page/deposit_page.dart';
import 'package:luggagemanagementsystem/page/forget_page.dart';
import 'package:luggagemanagementsystem/page/home_page.dart';
import 'package:luggagemanagementsystem/page/language_page.dart';
import 'package:luggagemanagementsystem/page/login_page.dart';
import 'package:luggagemanagementsystem/page/me_page.dart';
import 'package:luggagemanagementsystem/page/receive_page.dart';

Handler rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  return LoginPage();
  return HomePage();
});

Handler forgetHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ForgetPage();
});

Handler homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

Handler depositHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DepositPage();
});

Handler receiveHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ReceivePage();
});

Handler meHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MePage();
});

Handler languageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LanguagePage();
});
