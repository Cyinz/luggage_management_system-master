import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/router/router_handler.dart';
import 'router_handler.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String deposit = "/deposit";
  static String receive = "/receive";

  static void configureRouters(Router router) {
    // 出现不存在的路径时
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("没有该路由");
      },
    );

    router.define(root, handler: rootHandler);
    router.define(home, handler: homeHandler);
    router.define(deposit, handler: depositHandler);
    router.define(receive, handler: receiveHandler);
  }
}
