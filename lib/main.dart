import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:luggagemanagementsystem/local/my_localizations_delegate.dart';
import 'package:luggagemanagementsystem/provide/check_update.dart';
import 'package:luggagemanagementsystem/provide/deposit_form.dart';
import 'package:luggagemanagementsystem/provide/forget_form.dart';
import 'package:luggagemanagementsystem/provide/home_drawer.dart';
import 'package:luggagemanagementsystem/provide/home_order.dart';
import 'package:luggagemanagementsystem/provide/login_form.dart';
import 'package:luggagemanagementsystem/provide/me_form.dart';
import 'package:luggagemanagementsystem/provide/receive_form.dart';
import 'package:luggagemanagementsystem/provide/reset_form.dart';
import 'package:luggagemanagementsystem/provide/search_form.dart';
import 'package:luggagemanagementsystem/provide/update_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/router/routes.dart';
import 'package:provide/provide.dart';

void main() {
  var providers = Providers();
  var loginForm = LoginForm();
  var forgetForm = ForgetForm();
  var homeDrawer = HomeDrawer();
  var depositForm = DepositForm();
  var homeOrder = HomeOrder();
  var receiveForm = ReceiveForm();
  var meForm = MeForm();
  var resetForm = ResetForm();
  var updateForm = UpdateForm();
  var searchForm = SearchForm();
  var checkUpdate = CheckUpdate();
  providers
    ..provide(Provider<LoginForm>.value(loginForm))
    ..provide(Provider<ForgetForm>.value(forgetForm))
    ..provide(Provider<HomeDrawer>.value(homeDrawer))
    ..provide(Provider<DepositForm>.value(depositForm))
    ..provide(Provider<HomeOrder>.value(homeOrder))
    ..provide(Provider<ReceiveForm>.value(receiveForm))
    ..provide(Provider<MeForm>.value(meForm))
    ..provide(Provider<ResetForm>.value(resetForm))
    ..provide(Provider<UpdateForm>.value(updateForm))
    ..provide(Provider<SearchForm>.value(searchForm))
    ..provide(Provider<CheckUpdate>.value(checkUpdate));
  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    ),
  );
}

class AppSetting {
  AppSetting();

  Null Function(Locale locale) changeLocale;
  Locale locale;
  List<Locale> supportedLocales = [
    Locale('zh', 'CN'), //简体中文
    Locale('zh', 'HK'), //繁体中文
    Locale('en', "US"), //美国英语
  ];
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  static AppSetting setting = AppSetting();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setting.locale = Locale('zh', 'CN');
    setting.changeLocale = (Locale locale) {
      if (setting.supportedLocales
          .map((locale) {
            return locale.toString();
          })
          .toSet()
          .contains(locale?.toString())) {
        setState(() {
          setting.locale = locale;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    //初始化路由
    final router = Router();
    Routes.configureRouters(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        locale: Locale('zh', 'CN'),
        //本地化
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          MyLocalizationsDelegate(),
        ],
        //本地化支持的语言
        supportedLocales: setting.supportedLocales,

        title: '行李管家',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blueGrey),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
