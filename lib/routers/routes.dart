import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/routers/router_handler.dart';

class Routes {
  static String root = "/";
  static String index = "/index";

  static void configureRouters(Router router) {
    // 出现不存在的路径时
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ERROR===>：ROUTE WAS NOT FOUND!!!");
      },
    );

    router.define(root, handler: rootHandler);
    router.define(index, handler: indexHandler);
  }
}
