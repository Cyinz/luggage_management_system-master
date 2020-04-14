import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/provide/search_by_phone_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchByPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通过手机号查找"),
        centerTitle: true,
      ),
      body: Provide<SearchByPhoneForm>(
        builder: (context, child, searchByPhoneForm) {
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
      key: Provide.value<SearchByPhoneForm>(context).searchByPhoneFormKey,
      child: ListView(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(100),
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 2, left: 10),
                border: OutlineInputBorder(),
                hintText: "请输入手机号",
              ),
              onSaved: (value) {
                Provide.value<SearchByPhoneForm>(context).setPhone(value);
              },
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
              onPressed: Provide.value<SearchByPhoneForm>(context).isDisabled
                  ? null
                  : () {
                      if (Provide.value<SearchByPhoneForm>(context)
                          .searchByPhoneFormKey
                          .currentState
                          .validate()) {
                        Provide.value<SearchByPhoneForm>(context)
                            .setIsDisabled(true);
                        Provide.value<SearchByPhoneForm>(context)
                            .searchByPhoneFormKey
                            .currentState
                            .save();
                        //  发送短信
                        send(context);
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

  //  发送短信
  send(BuildContext context) {
    FormData formData = FormData.fromMap({
      'phonenumber': Provide.value<SearchByPhoneForm>(context).phone,
    });
    postRequest('search_by_phone', formData: formData).then((data) {
      if (data['status'] == 200) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return _successDialog(context, data['data']);
          },
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return _failureDialog(context);
          },
        );
      }
    });
  }

  //  发送成功弹窗
  Widget _successDialog(BuildContext context, String codeMsg) {
    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 30,
                left: 30,
                bottom: 20,
              ),
              child: Text(
                "发送成功",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(70),
                ),
              ),
            ),
            Center(
              child: QrImage(
                data: codeMsg,
                size: 200,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  Provide.value<SearchByPhoneForm>(context)
                      .setIsDisabled(false);
                  Navigator.pop(context);
                  Application.router.navigateTo(
                    context,
                    '/home',
                    replace: true,
                    clearStack: true,
                  );
                },
                child: Text(
                  "确认",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //  寄存失败弹窗
  Widget _failureDialog(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text("发送失败"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Provide.value<SearchByPhoneForm>(context)
                  .searchByPhoneFormKey
                  .currentState
                  .reset();
              Provide.value<SearchByPhoneForm>(context).setIsDisabled(false);
              Navigator.pop(context);
            },
            child: Text("确认"),
          ),
        ],
      ),
    );
  }
}
