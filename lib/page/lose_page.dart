import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/router/application.dart';

class LosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("凭证丢失"),
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
                Application.router.navigateTo(context, '/search_by_phone');
              },
              child: Text("通过手机号查找"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            child: OutlineButton(
              highlightedBorderColor: Colors.blueGrey,
              onPressed: () {
                Application.router.navigateTo(context, '/search_by_qrcode');
              },
              child: Text("验证身份信息领取"),
            ),
          ),
        ],
      ),
    );
  }
}
