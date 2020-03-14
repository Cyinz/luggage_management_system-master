import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/router/router_handler.dart';

import 'router_handler.dart';

class Routes {
  static String root = "/";
  static String index = "/index";
  static String home = "/home";

  static void configureRouters(Router router) {
    // 出现不存在的路径时
    router.notFoundHandler = new Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("没有该路由");
      },
    );

    router.define(root, handler: rootHandler);
    router.define(index, handler: indexHandler);
    router.define(home, handler: homeHandler);
  }
}
