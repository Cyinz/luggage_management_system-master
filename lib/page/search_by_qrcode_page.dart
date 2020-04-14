import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/provide/search_by_qrcode_form.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';

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
              onPressed: Provide.value<SearchByQrcodeForm>(context).isDisabled
                  ? null
                  : () {
                      if (Provide.value<SearchByQrcodeForm>(context)
                          .searchByQrcodeFormKey
                          .currentState
                          .validate()) {
                        Provide.value<SearchByQrcodeForm>(context)
                            .setIsDisabled(true);
                        Provide.value<SearchByQrcodeForm>(context)
                            .searchByQrcodeFormKey
                            .currentState
                            .save();
                        //  查找
                        search(context);
                      }
                    },
              child: Text(
                "重新发送取行李码",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
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

  //  查找
  search(BuildContext context) {
    FormData formData = FormData.fromMap({
      'savername': Provide.value<SearchByQrcodeForm>(context).savername,
      'date': Provide.value<SearchByQrcodeForm>(context).date,
    });
    postRequest('/search_by_qrcode', formData: formData).then((data) {

    });
  }
}
