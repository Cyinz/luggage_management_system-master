import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luggagemanagementsystem/provide/reset_form.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1980);
    return Scaffold(
      appBar: AppBar(
        title: Text("修改登陆密码"),
        centerTitle: true,
      ),
      body: Provide<ResetForm>(
        builder: (context, child, resetForm) {
          return GestureDetector(
            child: ListView(
              children: <Widget>[
                _resetForm(context),
              ],
            ),
            // 点击空白处收回键盘
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          );
        },
      ),
    );
  }

  //  修改密码表单
  Widget _resetForm(BuildContext context) {
    return Form(
      key: Provide.value<ResetForm>(context).resetFormKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        children: <Widget>[
          _userLoginName(context),
          _password(context),
          _newPassword(context),
          resetBtn(context),
        ],
      ),
    );
  }

  //  登陆账号输入框
  Widget _userLoginName(BuildContext context) {
    return Container(
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
                "登陆账号:",
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
                ),
                onSaved: (value) {
                  Provide.value<ResetForm>(context).setUserLoginName(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  原密码输入框
  Widget _password(BuildContext context) {
    return Container(
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
                "原密码:",
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
                ),
                onSaved: (value) {
                  Provide.value<ResetForm>(context).setPassword(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  新密码输入框
  Widget _newPassword(BuildContext context) {
    return Container(
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
                "新密码:",
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
                ),
                onSaved: (value) {
                  Provide.value<ResetForm>(context).setNewPassword(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  修改按钮
  Widget resetBtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(80.0),
        left: ScreenUtil().setWidth(30.0),
        right: ScreenUtil().setWidth(30.0),
      ),
      child: RaisedButton(
        color: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          "确认修改",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: Provide.value<ResetForm>(context).isDisabled
            ? null
            : () {
                if (Provide.value<ResetForm>(context)
                    .resetFormKey
                    .currentState
                    .validate()) {
                  Provide.value<ResetForm>(context).setIsDisabled(true);
                  Provide.value<ResetForm>(context)
                      .resetFormKey
                      .currentState
                      .save();
                  var flag = true;
                  if (Provide.value<ResetForm>(context).userLoginName == null ||
                      Provide.value<ResetForm>(context).userLoginName == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "登陆账号不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (Provide.value<ResetForm>(context).password == null ||
                      Provide.value<ResetForm>(context).password == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "原密码不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (Provide.value<ResetForm>(context).newPassword == null ||
                      Provide.value<ResetForm>(context).newPassword == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "新密码不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (flag == false) {
                    Provide.value<ResetForm>(context).setIsDisabled(false);
                  } else {
                    //  修改密码
                    resetPassword(context);
                  }
                }
              },
      ),
    );
  }

  //  修改密码
  resetPassword(BuildContext context) {
    FormData formData = FormData.fromMap({
      'userloginname': Provide.value<ResetForm>(context).userLoginName,
      'password': Provide.value<ResetForm>(context).password,
      'newpassword': Provide.value<ResetForm>(context).newPassword,
    });
    postRequest('resetPassword', formData: formData).then((data) {});
  }
}
