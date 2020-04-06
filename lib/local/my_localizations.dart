import 'package:flutter/material.dart';

class MyLocalizations {
  final Locale locale;

  MyLocalizations(this.locale);

  static Map<String, Map<String, String>> localizedValuesMap = {
    'en_US': {
      'DemoName': 'Luggage Management',
      'HotelOrder': 'Hotel Order',
      'WeekOrders': 'Week Orders',
      'TodayDeposit': 'Today Deposit',
      'TodayReceive': 'Today Receive',
      'ClerkOrder': 'Clerk Order',
      'Deposit': 'DEPOSIT',
      'Receive': 'RECEIVE',
      'HistoryOrder': 'histroy orders',
      'Me': 'Personal information',
      'SearchOrder': 'Search order',
      'LanguageSetting': 'Language setting',
      'CheckUpdate': 'Check update',
      'SignOut': 'Sing out',
    },
    'zh_CN': {
      'DemoName': '智能酒店行李管理',
      'HotelOrder': '酒店订单',
      'WeekOrders': '一周总单数',
      'TodayDeposit': '今日寄存数',
      'TodayReceive': '今日领取数',
      'ClerkOrder': '行李员订单',
      'Deposit': '行李寄存',
      'Receive': '行李领取',
      'HistoryOrder': '历史订单',
      'Me': '个人信息',
      'SearchOrder': '订单查询',
      'LanguageSetting': '语言设置',
      'CheckUpdate': '检查更新',
      'SignOut': '退出登陆',
    },
    'zh_HK': {
      'DemoName': '智能酒店行李管理',
      'HotelOrder': '酒店訂單',
      'WeekOrders': '一周總單數',
      'TodayDeposit': '今日寄存數',
      'TodayReceive': '今日領取數',
      'ClerkOrder': '行李員訂單',
      'Deposit': '行李寄存',
      'Receive': '行李領取',
      'HistoryOrder': '歷史訂單',
      'Me': '個人信息',
      'SearchOrder': '訂單查詢',
      'LanguageSetting': '語言設置',
      'CheckUpdate': '檢查更新',
      'SignOut': '退出登陸',
    }
  };

  get DemoName {
    return localizedValuesMap[locale.toString()]['DemoName'];
  }

  get HotelOrder {
    return localizedValuesMap[locale.toString()]['HotelOrder'];
  }

  get WeekOrders {
    return localizedValuesMap[locale.toString()]['WeekOrders'];
  }

  get TodayDeposit {
    return localizedValuesMap[locale.toString()]['TodayDeposit'];
  }

  get TodayReceive {
    return localizedValuesMap[locale.toString()]['TodayReceive'];
  }

  get ClerkOrder {
    return localizedValuesMap[locale.toString()]['ClerkOrder'];
  }

  get Deposit {
    return localizedValuesMap[locale.toString()]['Deposit'];
  }

  get Receive {
    return localizedValuesMap[locale.toString()]['Receive'];
  }

  get HistoryOrder {
    return localizedValuesMap[locale.toString()]['HistoryOrder'];
  }

  get Me {
    return localizedValuesMap[locale.toString()]['Me'];
  }

  get SearchOrder {
    return localizedValuesMap[locale.toString()]['SearchOrder'];
  }

  get LanguageSetting {
    return localizedValuesMap[locale.toString()]['LanguageSetting'];
  }

  get CheckUpdate {
    return localizedValuesMap[locale.toString()]['CheckUpdate'];
  }

  get SignOut {
    return localizedValuesMap[locale.toString()]['SignOut'];
  }

  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }
}
