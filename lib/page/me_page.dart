import 'package:flutter/material.dart';
import 'package:luggagemanagementsystem/provide/me_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getMsg(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("个人信息"),
        centerTitle: true,
      ),
      body: Provide<MeForm>(
        builder: (context, child, meForm) {
          return Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://www.51yuansu.com/pic2/cover/00/39/51/5812ec5184228_610.jpg"),
                    backgroundColor: Colors.grey[400],
                    radius: 100.0,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("用户编号:"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      child: Text("${Provide.value<MeForm>(context).id}"),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("用户姓名:"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      child: Text("${Provide.value<MeForm>(context).username}"),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("所属酒店:"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      child: Text("${Provide.value<MeForm>(context).hotel}"),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("联系方式:"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      child:
                          Text("${Provide.value<MeForm>(context).phonenumber}"),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.teal,
                      onPressed: () {
                        Application.router.navigateTo(context, '/update');
                      },
                      child: Text(
                        "修改个人资料",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        Application.router.navigateTo(context, '/reset');
                      },
                      child: Text(
                        "修改登陆密码",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  getMsg(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Provide.value<MeForm>(context).setId(sharedPreferences.get('clerkId'));
    Provide.value<MeForm>(context)
        .setUsername(sharedPreferences.get('clerkUserName'));
    Provide.value<MeForm>(context).setImg(sharedPreferences.get('clerkImg'));
    Provide.value<MeForm>(context)
        .setRight(sharedPreferences.get('clerkRight'));
    Provide.value<MeForm>(context)
        .setHotel(sharedPreferences.get('clerkHotel'));
    Provide.value<MeForm>(context)
        .setState(sharedPreferences.get('clerkState'));
    Provide.value<MeForm>(context)
        .setPhone(sharedPreferences.get('clerkPhoneNumber'));
  }
}
