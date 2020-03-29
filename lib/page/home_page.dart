import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/page/widget/swiperDiy.dart';
import 'package:luggagemanagementsystem/provide/deposit_form.dart';
import 'package:luggagemanagementsystem/provide/home_drawer.dart';
import 'package:luggagemanagementsystem/provide/home_order.dart';
import 'package:luggagemanagementsystem/provide/receive_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
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
      print("返回到主页");
    }

    ScreenUtil.init(context, width: 1080, height: 1980);
    getClerk(context);
    getOrderMsg(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("智能酒店行李管理"),
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
//                      Provide.value<HomeDrawer>(context).clerkImg,
                      "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=430089504,3674027973&fm=26&gp=0.jpg",
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
                  title: Text("个人信息"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.format_list_bulleted,
                    color: Colors.teal,
                  ),
                  title: Text("订单查询"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.teal,
                  ),
                  title: Text("语言设置"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.update,
                    color: Colors.teal,
                  ),
                  title: Text("检查更新"),
                  onTap: () {},
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
                  title: Text("退出登陆"),
                  onTap: () {},
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
          FormData formData = FormData.fromMap({
            'recievername': Provide.value<HomeDrawer>(context).clerkName,
          });
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
                      Text("历史订单"),
                    ],
                  ),
                ),
                //  行李员历史订单列表
                FutureBuilder(
                    future: postRequest('getClerkOrder',formData: formData),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("历史订单");
                        return ListView.builder(
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
                                          Image.network(
                                            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584214735946&di=68bf93a1c61da6e03c8b9bac9d6497da&imgtype=0&src=http%3A%2F%2Fimg.jk51.com%2Fimg_jk51%2F93051887.jpeg",
                                            width: ScreenUtil().setWidth(300),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(20),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "客户姓名:  ${snapshot.data[index]['saverid']}",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40),
                                                ),
                                              ),
                                              Text(
                                                "客户电话:  ${snapshot.data[index]['saverphonenumber']}",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40),
                                                ),
                                              ),
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
                  "酒店订单",
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
                "一周总单数",
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
                "今日寄存数",
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
                "今日领取数",
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
                  "行李员订单",
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
                "一周总单数",
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
                "今日寄存数",
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
                "今日领取数",
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
                "行李寄存",
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
                "行李领取",
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
  getOrderMsg(BuildContext context) {
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

  //  获取行李员历史订单
  getOrderByClerk() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString("clerkUserName");
    FormData formData = FormData.fromMap({
      'recievername': name,
    });
    return formData;
  }
}
