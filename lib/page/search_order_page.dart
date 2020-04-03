import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/provide/search_form.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';

class SearchOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单查询"),
        centerTitle: true,
      ),
      body: Provide<SearchForm>(
        builder: (context, child, searchForm) {
          return GestureDetector(
            child: _searchOrderForm(context),
            // 点击空白处收回键盘
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          );
        },
      ),
    );
  }

  //  查询订单列表
  Widget _searchOrderForm(BuildContext context) {
    return Form(
      key: Provide.value<SearchForm>(context).searchFormKey,
      child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: _getListBtn(context),
              ),
              Expanded(
                flex: 2,
                child: _searchField(context),
              ),
              Expanded(
                flex: 1,
                child: _searchBtn(context),
              ),
            ],
          ),
          _orderList(context),
        ],
      ),
    );
  }

  //  下拉筛选按钮
  Widget _getListBtn(BuildContext context) {
    return Container(
      child: DropdownButton(
        items: _getListData(),
        hint: Text("请选择查找方式"),
        onChanged: (value) {
          print(value);
          Provide.value<SearchForm>(context).setSearchType(value);
        },
        value: Provide.value<SearchForm>(context).searchType,
        isDense: true,
        isExpanded: true,
        underline: Container(),
      ),
    );
  }

  //  下拉筛选框返回组件
  List<DropdownMenuItem> _getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: Text("按客户手机号查找"),
      value: 1,
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: Text("按行李员姓名查找"),
      value: 2,
    );
    items.add(dropdownMenuItem2);
    return items;
  }

  //  查找输入框
  Widget _searchField(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: '请输入搜索内容',
        ),
        onSaved: (value) {
          Provide.value<SearchForm>(context).setSearchMsg(value);
        },
      ),
    );
  }

  //  搜索按钮
  Widget _searchBtn(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (Provide.value<SearchForm>(context)
              .searchFormKey
              .currentState
              .validate()) {
            Provide.value<SearchForm>(context)
                .searchFormKey
                .currentState
                .save();
            Provide.value<SearchForm>(context)
                .setShowType(Provide.value<SearchForm>(context).searchType);
          }
        },
        child: Text("搜索"),
      ),
    );
  }

  //  返回的订单列表
  Widget _orderList(BuildContext context) {
    if (Provide.value<SearchForm>(context).showType == 1) {
      return FutureBuilder(
          future: postRequest(
            'getOrderByPhone',
            formData: new FormData.fromMap({
              'phonenumber': Provide.value<SearchForm>(context).searchMsg,
            }),
          ),
          builder: (context, order) {
            if (order.hasData) {
              return Text(order.data.toString());
            } else {
              return Text("");
            }
          });
    } else if (Provide.value<SearchForm>(context).showType == 2) {
      return FutureBuilder(
          future: postRequest(
            'getClerkOrder',
            formData: new FormData.fromMap({
              'recievername': Provide.value<SearchForm>(context).searchMsg,
            }),
          ),
          builder: (context, order) {
            if (order.hasData) {
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
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    "订单编号:  ${order.data[index]['orderid']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(38),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            FutureBuilder(
                                future: postRequest('getLuggage',
                                    formData: new FormData.fromMap({
                                      'luggageid': order.data[index]
                                          ['luggageid'],
                                    })),
                                builder: (context, luggage) {
                                  if (luggage.hasData) {
                                    return Image.network(
                                      "http://luggage.vipgz2.idcfengye.com/luggage/image/${luggage.data['picture']}",
                                      width: ScreenUtil().setWidth(700),
                                    );
                                  } else {
                                    return Text("");
                                  }
                                }),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FutureBuilder(
                                    future: postRequest('getSaver',
                                        formData: new FormData.fromMap({
                                          'saverid': order.data[index]
                                              ['saverid']
                                        })),
                                    builder: (context, saver) {
                                      if (saver.hasData) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("客户姓名:"),
                                                )),
                                                Expanded(
                                                  child: Text(
                                                      saver.data['saverName']),
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
                                                  child: Text(saver
                                                      .data['phonenumber']),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Text("");
                                      }
                                    }),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.center,
                                      child: Text("寄存时间:"),
                                    )),
                                    Expanded(
                                      child: Text(
                                          order.data[index]['luggagesavetime']),
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
                                    : Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.center,
                                            child: Text("领取状态:"),
                                          )),
                                          Expanded(
                                            child: Text("未领取"),
                                          ),
                                        ],
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
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.center,
                                            child: Text("领取时间:"),
                                          )),
                                          Expanded(
                                            child: Text(""),
                                          ),
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
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.center,
                                            child: Text("领取客服:"),
                                          )),
                                          Expanded(
                                            child: Text(""),
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
          });
    } else {
      return Text("null");
    }
  }
}
