import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:luggagemanagementsystem/local/my_localizations.dart';
import 'package:luggagemanagementsystem/main.dart';
import 'package:luggagemanagementsystem/page/widget/swiperDiy.dart';
import 'package:luggagemanagementsystem/provide/deposit_form.dart';
import 'package:luggagemanagementsystem/provide/home_drawer.dart';
import 'package:luggagemanagementsystem/provide/home_order.dart';
import 'package:luggagemanagementsystem/provide/receive_form.dart';
import 'package:luggagemanagementsystem/provide/reset_form.dart';
import 'package:luggagemanagementsystem/provide/search_form.dart';
import 'package:luggagemanagementsystem/provide/update_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  //  轮播图片
  List _bannerList = [
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4107889869,778042762&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2084372179,1304842980&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1998422375,2835855911&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2541320403,1245867576&fm=26&gp=0.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      Provide.value<DepositForm>(context).clearDepositForm();
      Provide.value<ReceiveForm>(context).clearReceiveForm();
      Provide.value<ResetForm>(context).initResetForm();
      Provide.value<UpdateForm>(context).initUpdateForm();
      Provide.value<SearchForm>(context).initSearchForm();
      print("返回到主页");
    }
    ScreenUtil.init(context, width: 1080, height: 1980);
    getClerk(context);
    getOrderMsg(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations(MyAppState.setting.locale).DemoName),
        centerTitle: true,
      ),
      drawer: Provide<HomeDrawer>(
        builder: (context, child, homeDrawer) {
          return Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    Provide.value<HomeDrawer>(context).clerkName,
                  ),
                  accountEmail: Text(
                    Provide.value<HomeDrawer>(context).clerkHotel,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "http://luggage.vipgz2.idcfengye.com/luggage/image/${Provide.value<HomeDrawer>(context).clerkImg}",
                    ),
                    backgroundColor: Colors.grey[400],
                    radius: 40.0,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.teal,
                  ),
                  title: Text(MyLocalizations(MyAppState.setting.locale).Me),
                  onTap: () {
                    Application.router.navigateTo(context, "/me");
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.format_list_bulleted,
                    color: Colors.teal,
                  ),
                  title: Text(
                      MyLocalizations(MyAppState.setting.locale).SearchOrder),
                  onTap: () {
                    Application.router.navigateTo(context, '/search');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.teal,
                  ),
                  title: Text(MyLocalizations(MyAppState.setting.locale)
                      .LanguageSetting),
                  onTap: () {
                    Application.router.navigateTo(context, 'language');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.update,
                    color: Colors.teal,
                  ),
                  title: Text(
                      MyLocalizations(MyAppState.setting.locale).CheckUpdate),
                  onTap: () {
                    getVersion(context);
                  },
                ),
                //  占满剩余空间
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    height: 1,
                    color: Colors.grey[500],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(MyLocalizations(MyAppState.setting.locale).SignOut),
                  onTap: () {
                    Application.router.navigateTo(
                      context,
                      '/',
                      replace: true,
                      clearStack: true,
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(ScreenUtil.bottomBarHeight),
                ),
              ],
            ),
          );
        },
      ),
      body: Provide<HomeOrder>(
        builder: (context, child, homeOrder) {
          return EasyRefresh(
            child: ListView(
              children: <Widget>[
                SwiperDiy(swiperDataList: _bannerList),
                Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      _hotelRow(context),
                      Divider(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      _clerkRow(context),
                    ],
                  ),
                ),
                _buttonRow(context),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Text(MyLocalizations(MyAppState.setting.locale)
                          .HistoryOrder),
                    ],
                  ),
                ),
                //行李员历史订单列表
                FutureBuilder(
                    future: postRequest('getClerkOrder',
                        formData: FormData.fromMap({
                          'recievername':
                              Provide.value<HomeDrawer>(context).clerkName,
                        })),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("历史订单");
                        return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: EdgeInsets.all(10.0),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "订单编号:  ${snapshot.data[index]['orderid']}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(38),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          FutureBuilder(
                                              future: postRequest('getLuggage',
                                                  formData:
                                                      new FormData.fromMap({
                                                    'luggageid':
                                                        snapshot.data[index]
                                                            ['luggageid'],
                                                  })),
                                              builder: (context, luggage) {
                                                if (luggage.hasData) {
                                                  return Image.network(
                                                    "http://luggage.vipgz2.idcfengye.com/luggage/image/${luggage.data['picture']}",
                                                    width: ScreenUtil()
                                                        .setWidth(300),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(20),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              FutureBuilder(
                                                  future: postRequest(
                                                      'getSaver',
                                                      formData:
                                                          new FormData.fromMap({
                                                        'saverid':
                                                            snapshot.data[index]
                                                                ['saverid']
                                                      })),
                                                  builder: (context, saver) {
                                                    if (saver.hasData) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "客户姓名:  ${saver.data['saverName']}",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          40),
                                                            ),
                                                          ),
                                                          Text(
                                                            "客户电话:  ${saver.data['phonenumber']}",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          40),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      return Text("");
                                                    }
                                                  }),
                                              Text(
                                                "寄存时间:  ${snapshot.data[index]['luggagesavetime']}",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40),
                                                ),
                                              ),
                                              Text(
                                                "寄存客服:  ${snapshot.data[index]['recievername']}",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40),
                                                ),
                                              ),
                                              Text(
                                                "预计领取:  ${snapshot.data[index]['luggagesavefortime']}",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40),
                                                ),
                                              ),
                                              snapshot.data[index]
                                                          ['luggageistoken'] ==
                                                      1
                                                  ? Text(
                                                      "领取状态:  已领取",
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                      ),
                                                    )
                                                  : Text(
                                                      "领取状态:  未领取",
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                      ),
                                                    ),
                                              snapshot.data[index]
                                                          ['luggageistoken'] ==
                                                      1
                                                  ? Text(
                                                      "领取时间:  ${snapshot.data[index]['luggagegettime']}",
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                      ),
                                                    )
                                                  : Text(
                                                      "领取时间:",
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                      ),
                                                    ),
                                              snapshot.data[index]
                                                          ['luggageistoken'] ==
                                                      1
                                                  ? Text(
                                                      "领取客服:  ${snapshot.data[index]['givername']}",
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                      ),
                                                    )
                                                  : Text(
                                                      "领取客服:",
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(40),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Text("");
                      }
                    }),
              ],
            ),
            onRefresh: () async {
              print("下拉刷新");
              getOrderMsg(context);
            },
            onLoad: () async {
              await Future.delayed(Duration(seconds: 2), () {
                print("上拉加载");
              });
            },
            header: BallPulseHeader(),
            footer: BallPulseFooter(
              enableHapticFeedback: false,
              enableInfiniteLoad: false,
            ),
          );
        },
      ),
    );
  }

  //  酒店订单数据
  Widget _hotelRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: ScreenUtil().setHeight(200.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.home,
                  size: ScreenUtil().setSp(125),
                  color: Colors.deepPurpleAccent[100],
                ),
                Text(
                  MyLocalizations(MyAppState.setting.locale).HotelOrder,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(35),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "${Provide.value<HomeOrder>(context).hotelWeekOrder}",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: ScreenUtil().setSp(100.0),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                MyLocalizations(MyAppState.setting.locale).WeekOrders,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "${Provide.value<HomeOrder>(context).hotelTodayDeposit}",
                style: TextStyle(
                  color: Colors.redAccent[100],
                  fontSize: ScreenUtil().setSp(100.0),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                MyLocalizations(MyAppState.setting.locale).TodayDeposit,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "${Provide.value<HomeOrder>(context).hotelTodayReceive}",
                style: TextStyle(
                  color: Colors.lightBlueAccent[100],
                  fontSize: ScreenUtil().setSp(100.0),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                MyLocalizations(MyAppState.setting.locale).TodayReceive,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //  行李员订单数据
  Widget _clerkRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: ScreenUtil().setHeight(200.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: ScreenUtil().setSp(125),
                  color: Colors.deepPurpleAccent[100],
                ),
                Text(
                  MyLocalizations(MyAppState.setting.locale).ClerkOrder,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(35),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "${Provide.value<HomeOrder>(context).clerkWeekOrder}",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: ScreenUtil().setSp(100.0),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                MyLocalizations(MyAppState.setting.locale).WeekOrders,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "${Provide.value<HomeOrder>(context).clerkTodayDeposit}",
                style: TextStyle(
                  color: Colors.redAccent[100],
                  fontSize: ScreenUtil().setSp(100.0),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                MyLocalizations(MyAppState.setting.locale).TodayDeposit,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "${Provide.value<HomeOrder>(context).clerkTodayReceive}",
                style: TextStyle(
                  color: Colors.lightBlueAccent[100],
                  fontSize: ScreenUtil().setSp(100.0),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                MyLocalizations(MyAppState.setting.locale).TodayReceive,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //  寄存领取按钮栏
  Widget _buttonRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.card_giftcard,
                color: Colors.teal,
              ),
              title: Text(
                MyLocalizations(MyAppState.setting.locale).Deposit,
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                String token = sharedPreferences.getString('Token');
                FormData formData = FormData.fromMap({
                  'token': token,
                });
                postRequest('checkToken', formData: formData)
                    .then((data) async {
                  //  Token验证通过
                  if (data['status'] == 200) {
                    Application.router.navigateTo(context, '/deposit');
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return _failureTokenDialog(context);
                        });
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.card_travel,
                color: Colors.teal,
              ),
              title: Text(
                MyLocalizations(MyAppState.setting.locale).Receive,
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                String token = sharedPreferences.getString('Token');
                FormData formData = FormData.fromMap({
                  'token': token,
                });
                postRequest('checkToken', formData: formData)
                    .then((data) async {
                  //  Token验证通过
                  if (data['status'] == 200) {
                    Application.router.navigateTo(context, '/receive');
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return _failureTokenDialog(context);
                        });
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  //  读取登陆行李员信息
  getClerk(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Provide.value<HomeDrawer>(context)
        .setClerkId(sharedPreferences.getString('clerkId'));
    Provide.value<HomeDrawer>(context)
        .setClerkName(sharedPreferences.getString('clerkUserName'));
    Provide.value<HomeDrawer>(context)
        .setClerkImg(sharedPreferences.getString('clerkImg'));
    Provide.value<HomeDrawer>(context)
        .setClerkHotel(sharedPreferences.getString('clerkHotel'));
  }

  //  获取订单统计信息
  getOrderMsg(BuildContext context) async {
    //  添加酒店订单数据
    addHotelDeposit();
    addHotelReceive();
    //  取酒店订单统计数据
    hotelWeekOrder(context);
    getHotelDeposit(context);
    getHotelReceive(context);
    //  添加行李员订单数据
    addClerkDeposit();
    addClerkReceive();
    //  取行李员订单数据
    clerkWeekOrder(context);
    getClerkDeposit(context);
    getClerkReceive(context);
  }

  //  验证Token失败弹窗
  Widget _failureTokenDialog(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(""),
        content: Text("登陆已过期，请重新登陆!"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //  清空所有
              clear(context);
            },
            child: Text("确认"),
          )
        ],
      ),
    );
  }

//  清空信息，重新登陆
  clear(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Application.router.navigateTo(
      context,
      '/',
      replace: true,
      clearStack: true,
    );
  }

  //  酒店业务-添加前七天每日寄存数据
  addHotelDeposit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String hotel = sharedPreferences.getString('clerkHotel');
    FormData formData = FormData.fromMap({
      'hotel': hotel,
    });
    postRequest('addHotelDeposit', formData: formData).then((data) {
      if (data['status'] == 200) {
        print("添加酒店寄存数据成功");
      } else {
        print("添加酒店寄存数据失败");
      }
    });
  }

  //  酒店业务-添加前七天每日领取数据
  addHotelReceive() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String hotel = sharedPreferences.getString('clerkHotel');
    FormData formData = FormData.fromMap({
      'hotel': hotel,
    });
    postRequest('addHotelReceive', formData: formData).then((data) {
      if (data['status'] == 200) {
        print("添加酒店领取数据成功");
      } else {
        print("添加酒店领取数据失败");
      }
    });
  }

  //  酒店业务-一周总数
  hotelWeekOrder(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String hotel = sharedPreferences.getString('clerkHotel');
    FormData formData = FormData.fromMap({
      'hotel': hotel,
    });
    postRequest('hotelWeekOrder', formData: formData).then((data) {
      if (data['status'] == 200) {
        print("获取酒店订单一周总数");
        Provide.value<HomeOrder>(context).setHotelWeekOrder(data['data']);
      }
    });
  }

  //  酒店业务-获取每日寄存数
  getHotelDeposit(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String hotel = sharedPreferences.getString('clerkHotel');
    FormData formData = FormData.fromMap({
      'hotel': hotel,
    });
    postRequest('getHotelDeposit', formData: formData).then((data) {
      print(data);
      print("获取酒店订单每日寄存数");
      Provide.value<HomeOrder>(context).setHotelTodayDeposit(data['day1']);
    });
  }

  //  酒店业务-获取每日领取数
  getHotelReceive(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String hotel = sharedPreferences.getString('clerkHotel');
    FormData formData = FormData.fromMap({
      'hotel': hotel,
    });
    postRequest('getHotelReceive', formData: formData).then((data) {
      print(data);
      print("获取酒店订单每日领取数");
      Provide.value<HomeOrder>(context).setHotelTodayReceive(data['day1']);
    });
  }

  //  个人业务-添加前七天每日寄存数
  addClerkDeposit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('clerkUserName');
    FormData formData = FormData.fromMap({
      'name': name,
    });
    postRequest('addClerkDeposit', formData: formData).then((data) {
      if (data['status'] == 200) {
        print("添加行李员寄存数据成功");
      } else {
        print("添加行李员寄存数据失败");
      }
    });
  }

  //  个人业务-添加前七天每日领取数
  addClerkReceive() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('clerkUserName');
    FormData formData = FormData.fromMap({
      'name': name,
    });
    postRequest('addClerkReceive', formData: formData).then((data) {
      if (data['status'] == 200) {
        print("添加行李员领取数据成功");
      } else {
        print("添加行李员领取数据失败");
      }
    });
  }

  //  个人业务-一周总数
  clerkWeekOrder(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('clerkUserName');
    FormData formData = FormData.fromMap({
      'name': name,
    });
    postRequest('clerkWeekOrder', formData: formData).then((data) {
      if (data['status'] == 200) {
        print("获取行李员订单一周总数");
        Provide.value<HomeOrder>(context).setClerkWeekOrder(data['data']);
      }
    });
  }

  //  酒店业务-获取每日寄存数
  getClerkDeposit(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('clerkUserName');
    FormData formData = FormData.fromMap({
      'name': name,
    });
    postRequest('getClerkDeposit', formData: formData).then((data) {
      print(data);
      print("获取行李员订单每日寄存数");
      Provide.value<HomeOrder>(context).setClerkTodayDeposit(data['day1']);
    });
  }

  //  酒店业务-获取每日领取数
  getClerkReceive(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('clerkUserName');
    FormData formData = FormData.fromMap({
      'name': name,
    });
    postRequest('getClerkReceive', formData: formData).then((data) {
      print(data);
      print("获取行李员订单每日领取数");
      Provide.value<HomeOrder>(context).setClerkTodayReceive(data['day1']);
    });
  }

  //  获取版本号
  getVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.version);

    postRequest('getApk').then(
      (data) {
        print(data);
        if (packageInfo.version == data['version']) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Container(
                child: AlertDialog(
                  title: Text("检查更新"),
                  content: Text("当前应用已是最新版本"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("确认"),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Container(
                child: AlertDialog(
                  title: Text("检查更新"),
                  content: Text("检测到新版本，确认更新"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("取消"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Container(
                              child: Dialog(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 100,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Center(
                                          child: SizedBox(
                                            height: 6.0,
                                            child: LinearProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "返回后台下载",
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                        //  下载
                        download(
                          context,
                          "http://luggage.vipgz2.idcfengye.com/luggage/image/${data['url']}",
                        );
                      },
                      child: Text("下载"),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  //  下载安装apk
  download(BuildContext context, String urlPath) async {
    Response response;
    Dio dio = Dio();
    Directory externalDir;
    externalDir = await getExternalStorageDirectory();
    response = await dio.download(
      urlPath,
      externalDir.path + "my.apk",
      onReceiveProgress: (int count, int total) {
        print("$count / $total");
      },
    );
    print("下载结果: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("下载完成");
      InstallPlugin.installApk(externalDir.path + "my.apk",
              "com.example.luggagemanagementsystem")
          .then((result) {
        print('install apk $result');
      });
    }
  }
}
