import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/provide/search_by_qrcode_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchByQrcodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("验证身份信息领取"),
        centerTitle: true,
      ),
      body: Provide<SearchByQrcodeForm>(
        builder: (context, child, searchByQrcodeForm) {
          return SafeArea(
            child: GestureDetector(
              child: _searchForm(context),
              // 点击空白处收回键盘
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          );
        },
      ),
    );
  }

  //  搜索表单
  Widget _searchForm(BuildContext context) {
    return Form(
      key: Provide.value<SearchByQrcodeForm>(context).searchByQrcodeFormKey,
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50.0),
              right: ScreenUtil().setWidth(100.0),
            ),
            height: ScreenUtil().setHeight(80.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "客户姓名:",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 25),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 2, left: 10),
                        border: OutlineInputBorder(),
                        hintText: '请输入客户姓名',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: ScreenUtil().setSp(40),
                        ),
                      ),
                      onSaved: (value) {
                        Provide.value<SearchByQrcodeForm>(context)
                            .setSaverName(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50.0),
              right: ScreenUtil().setWidth(100.0),
            ),
            height: ScreenUtil().setHeight(80.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "寄存时间:",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 25),
                    child: InkWell(
                      onTap: () {
                        showPickerDateTime(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            Provide.value<SearchByQrcodeForm>(context).date,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(100),
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              onPressed: () {
                if (Provide.value<SearchByQrcodeForm>(context)
                    .searchByQrcodeFormKey
                    .currentState
                    .validate()) {
                  Provide.value<SearchByQrcodeForm>(context)
                      .searchByQrcodeFormKey
                      .currentState
                      .save();
                  //  查找
                  Provide.value<SearchByQrcodeForm>(context)
                      .setSearchResult(true);
                }
              },
              child: Text(
                "查找订单",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          _orderList(context),
        ],
      ),
    );
  }

  //  选择时间插件
  showPickerDateTime(BuildContext context) {
    new Picker(
      adapter: new DateTimePickerAdapter(
        type: PickerDateTimeType.kYMD,
        isNumberMonth: true,
        yearSuffix: "年",
        monthSuffix: "月",
        daySuffix: "日",
//        minValue: DateTime.now() ,
        minuteInterval: 1,
      ),
      title: new Text("预计领取时间"),
      textAlign: TextAlign.right,
      selectedTextStyle: TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
        Provide.value<SearchByQrcodeForm>(context).setDate(formatDate(
            DateTime.parse(picker.adapter.toString()),
            [yyyy, '-', mm, '-', dd]));
      },
    ).showModal(context);
  }

  //  返回的订单列表
  Widget _orderList(BuildContext context) {
    if (Provide.value<SearchByQrcodeForm>(context).searchResult == true) {
      Provide.value<SearchByQrcodeForm>(context).setSearchResult(false);
      print('开始查找');
      print(Provide.value<SearchByQrcodeForm>(context).savername);
      print(Provide.value<SearchByQrcodeForm>(context).date);
      return FutureBuilder(
          future: postRequest(
            'search_by_qrcode',
            formData: new FormData.fromMap({
              'savername': Provide.value<SearchByQrcodeForm>(context).savername,
              'date': Provide.value<SearchByQrcodeForm>(context).date,
            }),
          ),
          builder: (context, order) {
            if (order.hasData) {
              print(order.data);
              if(order.data.toString() == "[]"){
                print("空");
                return Card(
                  margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
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
                      child: Text("未查询到未领取订单信息"),
                    ),
                  ),
                );
              }
              else{
                return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.data.length,
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
                            children: <Widget>[
                              SizedBox(height: 10),
                              Image.network(
                                "http://luggage.vipgz2.idcfengye.com/luggage/image/${order.data[index]['luggagePicture']}",
                                width: ScreenUtil().setWidth(700),
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("客户姓名:"),
                                          )),
                                      Expanded(
                                        child:
                                        Text(order.data[index]['savername']),
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
                                        child: Text(
                                            order.data[index]['phonenumber']),
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
                                        child: Text(
                                            order.data[index]['savergender']),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("寄存时间:"),
                                          )),
                                      Expanded(
                                        child: Text(
                                            order.data[index]['luggageSavetime']),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("寄存客服:"),
                                          )),
                                      Expanded(
                                        child: Text(
                                            order.data[index]['recievername']),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("预计领取:"),
                                          )),
                                      Expanded(
                                        child: Text(order.data[index]
                                        ['luggagesavefortime']),
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
                                        child: Text(order.data[index]
                                        ['luggageTag']),
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
                                        child: Text(order.data[index]
                                        ['luggageLocation']),
                                      ),
                                    ],
                                  ),
                                  order.data[index]['luggageistoken'] == 1
                                      ? Row(
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
                                  )
                                      : Container(
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
                                        receive(context,order.data[index]['luggagegetcode']);
                                      },
                                      child: Text(
                                        "确认领取",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(60.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  order.data[index]['luggageistoken'] == 1
                                      ? Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("领取时间:"),
                                          )),
                                      Expanded(
                                        child: Text(order.data[index]
                                        ['luggagegettime']),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    children: <Widget>[
                                    ],
                                  ),
                                  order.data[index]['luggageistoken'] == 1
                                      ? Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("领取客服:"),
                                          )),
                                      Expanded(
                                        child: Text(
                                            order.data[index]['givername']),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    children: <Widget>[
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            } else {
              return Text("");
            }
          });
    } else {
      print(Provide.value<SearchByQrcodeForm>(context).searchResult);
      return Text("");
    }
  }

  //  领取
  receive(BuildContext context,String getCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String clerkName = sharedPreferences.getString('clerkUserName');
    FormData formData = FormData.fromMap({
      'getcode': getCode,
      'state': 1,
      'giver': clerkName,
    });
    postRequest('getluggage', formData: formData).then((data) {
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
}
