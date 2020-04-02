import 'package:flutter/cupertino.dart';

class MyLocalizations {
  final Locale locale;

  MyLocalizations(this.locale);

  static Map<String, Map<String, String>> localizedValuesMap = {
    'en_US': {
      'DemoName': 'Luggage Management',
    },
    'zh_CN': {
      'DemoName': '智能酒店行李管理',
    },
    'zh_HK': {
      'DemoName': '智能酒店行李管理',
    }
  };

  get DemoName {
    return localizedValuesMap[locale.toString()]['DemoName'];
  }

  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }
}
