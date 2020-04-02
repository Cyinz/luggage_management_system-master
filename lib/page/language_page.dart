import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/main.dart';
import 'package:luggagemanagementsystem/router/application.dart';

class LanguagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("语言设置"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: OutlineButton(
              highlightedBorderColor: Colors.blueGrey,
              onPressed: () {
                MyAppState.setting.changeLocale(Locale('zh','CN'));
                Application.router.navigateTo(context, '/home');
              },
              child: Text("简体中文"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: OutlineButton(
              highlightedBorderColor: Colors.blueGrey,
              onPressed: () {
                MyAppState.setting.changeLocale(Locale('zh','HK'));
                Application.router.navigateTo(context, '/home');              },
              child: Text("繁體中文"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: OutlineButton(
              highlightedBorderColor: Colors.blueGrey,
              onPressed: () {
                MyAppState.setting.changeLocale(Locale('en','US'));
                Application.router.navigateTo(context, '/home');              },
              child: Text("English"),
            ),
          ),
        ],
      ),
    );
  }
}
