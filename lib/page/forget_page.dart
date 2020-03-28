import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/model/clerk.dart';
import 'package:luggagemanagementsystem/provide/forget_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';

class ForgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      Provide.value<ForgetForm>(context).clearForgetForm();
    }

    ScreenUtil.init(context, width: 1080, height: 1980);
    return Scaffold(
      appBar: AppBar(
        title: Text("忘记密码"),
        centerTitle: true,
      ),
      body: Provide<ForgetForm>(
        builder: (context, child, forgetForm) {
          return SafeArea(
            child: GestureDetector(
              child: _forgetForm(context),
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

  //  忘记密码表单
  Widget _forgetForm(BuildContext context) {
    return Form(
      key: Provide.value<ForgetForm>(context).forgetFormKey,
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
                Provide.value<ForgetForm>(context).setPhone(value);
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  height: ScreenUtil().setHeight(100),
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 2, left: 10),
                      border: OutlineInputBorder(),
                      hintText: "请输入验证码",
                    ),
                    onSaved: (value) {
                      Provide.value<ForgetForm>(context).setCheckNumber(value);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: ScreenUtil().setHeight(100),
                  margin: EdgeInsets.only(right: 10),
                  child: RaisedButton(
                    onPressed: Provide.value<ForgetForm>(context).isSend
                        ? null
                        : () {
                            print("发送验证码");
                            setCountdown(context);
                            Provide.value<ForgetForm>(context)
                                .changeIsSend(true);
                            Provide.value<ForgetForm>(context)
                                .forgetFormKey
                                .currentState
                                .save();
                            sendCode(context);
                          },
                    child: Provide.value<ForgetForm>(context).isSend
                        ? Text(
                            "重新发送(${Provide.value<ForgetForm>(context).seconds})",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          )
                        : Text(
                            "发送验证码",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(40),
                            ),
                          ),
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              top: 100,
              left: 20,
              right: 20,
            ),
            child: RaisedButton(
              color: Colors.teal,
              onPressed: Provide.value<ForgetForm>(context).isDisabled
                  ? null
                  : () {
                      Provide.value<ForgetForm>(context)
                          .changeIsDisabled(false);
                      Provide.value<ForgetForm>(context)
                          .forgetFormKey
                          .currentState
                          .save();
                      login(context);
                    },
              child: Text(
                "确认登陆",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  开始倒计时
  setCountdown(BuildContext context) {
    print("开始倒计时");
    Timer timer;
    Provide.value<ForgetForm>(context).setSeconds(60);
    final call = (timer) {
      if (Provide.value<ForgetForm>(context).seconds < 1) {
        print("计时结束");
        Provide.value<ForgetForm>(context).changeIsSend(false);
        timer.cancel();
      } else {
        Provide.value<ForgetForm>(context)
            .setSeconds(Provide.value<ForgetForm>(context).seconds - 1);
      }
    };
    timer = Timer.periodic(Duration(seconds: 1), call);
  }

  //  发送验证码
  sendCode(BuildContext context) {
    FormData formData = FormData.fromMap({
      'phonenumber': Provide.value<ForgetForm>(context).phone,
    });
    postRequest('sendCode', formData: formData).then(
      (data) {
        //  发送成功
        if (data['status'] == 200) {
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Container(
                child: AlertDialog(
                  title: Text("发送失败"),
                  content: Text("验证码发送失败，请检查手机号是否正确"),
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

  //  验证码登轮
  login(BuildContext context) {
    FormData formData = FormData.fromMap({
      'code': Provide.value<ForgetForm>(context).checkNumber,
    });
    postRequest('codeLogin', formData: formData).then((data) {
      //  登陆成功
      if (data['status'] == 200) {
        //  保存token
        saveToken(data['data']);
        FormData formData2 = FormData.fromMap({
          'token': data['data'],
        });
        postRequest('getuser', formData: formData2).then((data) {
          if (data['status'] == 200) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                Clerk clerk = Clerk.fromJson(data['data']);
                saveClerk(clerk);
                return _successDialog(data, context);
              },
            );
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return _failureDialog("Token无效", context);
              },
            );
          }
        });
      }
      //  登陆失败
      else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return _failureDialog(data['msg'], context);
          },
        );
      }
    });
  }

  //  登陆成功弹窗
  Widget _successDialog(var data, BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text("登陆成功"),
        content: Text("欢迎您,${data['data']['username']}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Provide.value<ForgetForm>(context).changeIsDisabled(false);
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
  }

  //  登陆失败弹窗
  Widget _failureDialog(String msg, BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text("登陆失败"),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Provide.value<ForgetForm>(context)
                  .forgetFormKey
                  .currentState
                  .reset();
              Provide.value<ForgetForm>(context).changeIsDisabled(false);
              Navigator.pop(context);
            },
            child: Text("确认"),
          ),
        ],
      ),
    );
  }
}
