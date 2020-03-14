import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("智能酒店行李管理"),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Center(
        child: Text("HomePage}"),
      ),
    );
  }
}
