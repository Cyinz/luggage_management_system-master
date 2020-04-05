import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/model/clerk.dart';
import 'package:luggagemanagementsystem/provide/login_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';

import '../service/service_method.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1980);
    return Scaffold(
      body: Provide<LoginForm>(
        builder: (context, child, loginForm) {
          return SafeArea(
            child: GestureDetector(
              child: _loginForm(context),
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

  //  登陆表单
  Widget _loginForm(BuildContext context) {
    return Form(
      key: Provide.value<LoginForm>(context).loginFormKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        children: <Widget>[
          _formTitle(),
          _underLine(),
          _userLoginName(context),
          _password(context),
          _forgetPassword(context),
          _loginButton(context),
        ],
      ),
    );
  }

  //  登陆表单标题
  Widget _formTitle() {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(300),
      ),
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: ScreenUtil().setSp(120.0),
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  //  标题下划线
  Widget _underLine() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: Colors.black,
        height: ScreenUtil().setHeight(8),
        width: ScreenUtil().setWidth(270),
      ),
    );
  }

  //  用户名输入框
  Widget _userLoginName(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(100),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          labelText: "请输入用户名",
          helperText: '',
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "用户名不能为空";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          Provide.value<LoginForm>(context).saveUserName(value);
        },
      ),
    );
  }

  //  密码输入框
  Widget _password(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: Provide.value<LoginForm>(context).isObscure,
        decoration: InputDecoration(
          icon: Icon(Icons.keyboard),
          labelText: "请输入密码",
          helperText: "",
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Provide.value<LoginForm>(context).eyeColor,
            onPressed: () {
              Provide.value<LoginForm>(context).isObscureChange();
            },
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return "密码不能为空";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          Provide.value<LoginForm>(context).savePassword(value);
        },
      ),
    );
  }

  //  忘记密码按钮
  Widget _forgetPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        child: FlatButton(
          onPressed: () {
            Application.router.navigateTo(context, '/forget');
          },
          child: Text(
            "忘记密码",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(38.0),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  //  登陆按钮
  Widget _loginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(150),
      ),
      child: RaisedButton(
        color: Colors.black,
        shape: StadiumBorder(),
        child: Text(
          "登陆",
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(60.0),
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: Provide.value<LoginForm>(context).isDisabled
            ? null
            : () {
                if (Provide.value<LoginForm>(context)
                    .loginFormKey
                    .currentState
                    .validate()) {
                  Provide.value<LoginForm>(context).isDisabledChange();
                  Provide.value<LoginForm>(context)
                      .loginFormKey
                      .currentState
                      .save();
                  _login(Provide.value<LoginForm>(context).username,
                      Provide.value<LoginForm>(context).password, context);
                }
              },
      ),
    );
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
              Provide.value<LoginForm>(context).isDisabledChange();
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
              Provide.value<LoginForm>(context)
                  .loginFormKey
                  .currentState
                  .reset();
              Provide.value<LoginForm>(context).isDisabledChange();
              Navigator.pop(context);
            },
            child: Text("确认"),
          ),
        ],
      ),
    );
  }

  //  登陆方法
  _login(String username, String password, BuildContext context) async {
    FormData formData = FormData.fromMap({
      'userloginname': username,
      'password': password,
    });
    postRequest('login', formData: formData).then((data) {
      //  登陆成功
      if (data['status'] == 200) {
        //  保存token
        saveToken(data['data']);
        FormData formData2 = FormData.fromMap({
          'token': data['data'],
        });
        //  通过token获取登陆用户信息
        postRequest('getuser', formData: formData2).then((data) {
          if (data['status'] == 200) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                Clerk clerk = Clerk.fromJson(data['data']);
                //  保存行李员信息
                saveClerk(clerk);
                //  登陆成功
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
}
