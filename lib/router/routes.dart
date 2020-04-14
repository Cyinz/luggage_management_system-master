import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/router/router_handler.dart';
import 'router_handler.dart';

class Routes {
  static String root = "/";
  static String forget = "/forget";
  static String home = "/home";
  static String deposit = "/deposit";
  static String receive = "/receive";
  static String me = "/me";
  static String language = '/language';
  static String update = '/update';
  static String reset = '/reset';
  static String search = '/search';
  static String lose = '/lose';
  static String search_by_phone = '/search_by_phone';
  static String search_by_qrcode = '/search_by_qrcode';

  static void configureRouters(Router router) {
    // 出现不存在的路径时
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("没有该路由");
      },
    );

    router.define(root, handler: rootHandler);
    router.define(forget, handler: forgetHandler);
    router.define(home, handler: homeHandler);
    router.define(deposit, handler: depositHandler);
    router.define(receive, handler: receiveHandler);
    router.define(me, handler: meHandler);
    router.define(language, handler: languageHandler);
    router.define(update, handler: updateHandler);
    router.define(reset, handler: resetHandler);
    router.define(search, handler: searchHandler);
    router.define(lose, handler: loseHandler);
    router.define(search_by_phone, handler: searchByPhoneHandler);
    router.define(search_by_qrcode, handler: searchByQrcodeHandler);
  }
}
