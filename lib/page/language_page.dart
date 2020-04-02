import 'package:flutter/material.dart';

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
                Navigator.of(context).pop();
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
                Navigator.of(context).pop();
              },
              child: Text("繁體中文"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: OutlineButton(
              highlightedBorderColor: Colors.blueGrey,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("English"),
            ),
          ),
        ],
      ),
    );
  }
}
