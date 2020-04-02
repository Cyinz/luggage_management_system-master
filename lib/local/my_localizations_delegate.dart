import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/local/my_localizations.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  static MyLocalizationsDelegate delegate = const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'zh'].contains((locale.languageCode));
  }

  @override
  Future<MyLocalizations> load(Locale locale) {
    // TODO: implement load
    return SynchronousFuture<MyLocalizations>(new MyLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MyLocalizations> old) {
    // TODO: implement shouldReload
    return true;
  }
}