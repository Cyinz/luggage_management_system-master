import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/provide/receive_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("行李领取"),
      ),
      body: Provide<ReceiveForm>(builder: (context, child, receiveForm) {
        return GestureDetector(
          child: ListView(
            children: <Widget>[
              _receiveForm(context),
            ],
          ),
          // 点击空白处收回键盘
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        );
      }),
    );
  }

  //  领取表单
  Widget _receiveForm(BuildContext context) {
    return Form(
      key: Provide.value<ReceiveForm>(context).receiveFormKey,
      child: Column(
        children: <Widget>[
          _searchBar(context),
          _forgetBtn(context),
          _orderMsg(context),
        ],
      ),
    );
  }

  //  搜索栏
  Widget _searchBar(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(MaterialCommunityIcons.qrcode_scan),
              onPressed: () {
                scan(context);
              },
            ),
            Expanded(
              child: Container(
                height: ScreenUtil().setHeight(100),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 2, left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "请输入取行李码",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (Provide.value<ReceiveForm>(context)
                            .receiveFormKey
                            .currentState
                            .validate()) {
                          Provide.value<ReceiveForm>(context)
                              .receiveFormKey
                              .currentState
                              .save();
                          //  领取
                          checkReceiveOrder(context);
                        }
                      },
                    ),
                  ),
                  onSaved: (value) {
                    Provide.value<ReceiveForm>(context).setGetNumber(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  凭证丢失
  Widget _forgetBtn(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        child: FlatButton(
          onPressed: (){
            Application.router.navigateTo(context, '/lose');
          },
          child: Text(
            "凭证丢失",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(38.0),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  //  返回的行李订单信息
  Widget _orderMsg(BuildContext context) {
    if (Provide.value<ReceiveForm>(context).isSerach) {
      return Card(
        margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: 5,
            left: 10,
          ),
          width: double.infinity,
          child: Provide<ReceiveForm>(builder: (context, child, receiveForm) {
            return Column(
              children: <Widget>[
                SizedBox(height: 10),
                Center(
                  child: Image.network(
                    "http://luggage.vipgz2.idcfengye.com/luggage/image/${Provide.value<ReceiveForm>(context).picture}",
                    width: ScreenUtil().setWidth(700),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("客户姓名:"),
                    )),
                    Expanded(
                      child:
                          Text(Provide.value<ReceiveForm>(context).savername),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("客户性别:"),
                    )),
                    Expanded(
                      child:
                          Text(Provide.value<ReceiveForm>(context).saverGender),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("客户电话:"),
                    )),
                    Expanded(
                      child:
                          Text(Provide.value<ReceiveForm>(context).phonenumber),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("存放时间:"),
                    )),
                    Expanded(
                      child: Text(Provide.value<ReceiveForm>(context).savetime),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("预领时间:"),
                    )),
                    Expanded(
                      child:
                          Text(Provide.value<ReceiveForm>(context).storeToTime),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("行李标签:"),
                    )),
                    Expanded(
                      child: Text(Provide.value<ReceiveForm>(context).tag),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("行李位置:"),
                    )),
                    Expanded(
                      child: Text(Provide.value<ReceiveForm>(context).location),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("行李件数:"),
                    )),
                    Expanded(
                      child: Text(Provide.value<ReceiveForm>(context)
                          .number
                          .toString()),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("行李描述:"),
                    )),
                    Expanded(
                      child: Text(Provide.value<ReceiveForm>(context).describe),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text("寄存行李员:"),
                    )),
                    Expanded(
                      child: Text(
                          Provide.value<ReceiveForm>(context).receivername),
                    ),
                  ],
                ),
                Provide.value<ReceiveForm>(context).isReceive == 0
                    ? SizedBox(height: 30)
                    : Row(
                        children: <Widget>[
                          Expanded(
                              child: Align(
                            alignment: Alignment.center,
                            child: Text("领取状态:"),
                          )),
                          Expanded(
                            child: Text("已领取"),
                          ),
                        ],
                      ),
                Provide.value<ReceiveForm>(context).isReceive == 0
                    ? Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(100.0),
                          right: ScreenUtil().setWidth(100.0),
                          bottom: ScreenUtil().setHeight(30),
                        ),
                        child: RaisedButton(
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: () {
                            receive(context);
                          },
                          child: Text(
                            "确认领取",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(60.0),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: <Widget>[
                          Expanded(
                              child: Align(
                            alignment: Alignment.center,
                            child: Text("领取时间:"),
                          )),
                          Expanded(
                            child: Text(
                                Provide.value<ReceiveForm>(context).gettime),
                          ),
                        ],
                      ),
              ],
            );
          }),
        ),
      );
    } else {
      return Card(
        margin: EdgeInsets.fromLTRB(5, 150, 5, 0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          height: ScreenUtil().setHeight(500),
          width: double.infinity,
          child: Center(
            child: Text("未查询到订单信息"),
          ),
        ),
      );
    }
  }

  //  检查行李订单
  checkReceiveOrder(BuildContext context) async {
    //  验证Token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('Token');
    FormData formData = FormData.fromMap({
      'token': token,
    });
    postRequest('checkToken', formData: formData).then((data) async {
      //  Token验证通过
      if (data['status'] == 200) {
        String clerkName = sharedPreferences.getString('clerkUserName');
        FormData formData2 = FormData.fromMap({
          'getcode': Provide.value<ReceiveForm>(context).getNumber,
          'state': 0,
          'giver': clerkName,
        });
        postRequest('getluggage', formData: formData2).then(
          (data) {
            if (data['status'] == 250) {
              print(data['data']);
              Provide.value<ReceiveForm>(context)
                  .setSaverName(data['data']['savername']);
              Provide.value<ReceiveForm>(context)
                  .setPhoneNumber(data['data']['phonenumber']);
              Provide.value<ReceiveForm>(context)
                  .setSaverGender(data['data']['savergender']);
              Provide.value<ReceiveForm>(context)
                  .setSaveTime(data['data']['savetime']);
              Provide.value<ReceiveForm>(context)
                  .setStoreToTime(data['data']['saveforetime']);
              Provide.value<ReceiveForm>(context)
                  .setDescribe(data['data']['describe']);
              Provide.value<ReceiveForm>(context)
                  .setPicture(data['data']['picture']);
              Provide.value<ReceiveForm>(context)
                  .setNumber(data['data']['number']);
              Provide.value<ReceiveForm>(context).setTag(data['data']['tag']);
              Provide.value<ReceiveForm>(context)
                  .setLocation(data['data']['location']);
              Provide.value<ReceiveForm>(context)
                  .setIsReceive(data['data']['istoken']);
              Provide.value<ReceiveForm>(context)
                  .setGetTime(data['data']['gettime']);
              Provide.value<ReceiveForm>(context)
                  .setReceiverName(data['data']['receivername']);
              Provide.value<ReceiveForm>(context).changeIsSearch(true);
            } else {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Container(
                    child: AlertDialog(
                      title: Text("查询失败"),
                      content: Text("请检查取行李码是否正确"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("确认"),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      }
      //  Token过期
      else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return _failureTokenDialog(context);
          },
        );
      }
    });
  }

  //  确认领取
  receive(BuildContext context) async {
    print("确认领取");
    //  验证Token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('Token');
    FormData formData = FormData.fromMap({
      'token': token,
    });
    postRequest('checkToken', formData: formData).then((data) async {
      //  Token验证通过
      if (data['status'] == 200) {
        String clerkName = sharedPreferences.getString('clerkUserName');
        FormData formData2 = FormData.fromMap({
          'getcode': Provide.value<ReceiveForm>(context).getNumber,
          'state': 1,
          'giver': clerkName,
        });
        postRequest('getluggage', formData: formData2).then((data) {
          if (data['status'] == 200) {
            //  领取成功
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Container(
                  child: AlertDialog(
                    title: Text("领取成功"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Application.router.navigateTo(
                            context,
                            '/home',
                            replace: true,
                            clearStack: true,
                          );
                        },
                        child: Text("确认"),
                      ),
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
                    title: Text("领取失败"),
                    content: Text("请检查取行李码是否正确"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("确认"),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        });
      }
      //  Token过期
      else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return _failureTokenDialog(context);
          },
        );
      }
    });
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

  //  扫描二维码
  Future scan(BuildContext context) async {
    try {
      //  此处为扫码结果，barcode为二维码的内容
      String barcode = await BarcodeScanner.scan();
      Provide.value<ReceiveForm>(context).setGetNumber(barcode);
      //  扫码成功获取订单信息
      checkReceiveOrder(context);
      print('扫码结果: ' + barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        // 未授予APP相机权限
        print('未授予APP相机权限');
      } else {
        // 扫码错误
        print('扫码错误: $e');
      }
    } on FormatException {
      // 进入扫码页面后未扫码就返回
      print('进入扫码页面后未扫码就返回');
    } catch (e) {
      // 扫码错误
      print('扫码错误: $e');
    }
  }
}
