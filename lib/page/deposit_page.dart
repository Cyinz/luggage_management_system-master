import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/provide/deposit_form.dart';
import 'package:provide/provide.dart';
import 'package:date_format/date_format.dart';

class DepositPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("行李寄存"),
      ),
      body: Provide<DepositForm>(
        builder: (context, child, depositForm) {
          return GestureDetector(
            child: ListView(
              children: <Widget>[
                _depositForm(context),
                _depositButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  //  寄存表单
  Widget _depositForm(BuildContext context) {
    return Form(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        children: <Widget>[
          _formTitle(),
          _underline(),
          _savernameField(context),
          _phoneField(context),
          _tagField(context),
          _genderRadio(context),
          _storeToTime(context),
          _number(context),
          _picture(context),
          _describeField(context),
        ],
      ),
    );
  }

  //  表单标题
  Widget _formTitle() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20.0)),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.add_to_photos,
            size: ScreenUtil().setSp(80.0),
          ),
          Text(
            "新建订单",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(80.0),
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      ),
    );
  }

  //  标题下划线
  Widget _underline() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: Colors.black,
        height: ScreenUtil().setHeight(8),
        width: ScreenUtil().setWidth(270),
      ),
    );
  }

  //  姓名输入框
  Widget _savernameField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(200.0),
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
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入客户姓名',
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  手机号输入框
  Widget _phoneField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.0),
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
                "客户手机:",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(40.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入客户手机',
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  行李标签输入框
  Widget _tagField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.0),
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
                "行李标签:",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(40.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入行李绑定标签号',
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  性别选择按钮
  Widget _genderRadio(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.0),
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
                "客户性别:",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(40.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesome.male,
                  color: Colors.blue,
                  size: ScreenUtil().setSp(70.0),
                ),
                Text(
                  '先生',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(40.0),
                    color: Colors.blue,
                  ),
                ),
                Radio(
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Icon(
                  FontAwesome.female,
                  color: Colors.pinkAccent,
                  size: ScreenUtil().setSp(70.0),
                ),
                Text(
                  '女士',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(40.0),
                    color: Colors.pinkAccent,
                  ),
                ),
                Radio(
                  value: 2,
                  groupValue: 0,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  预计领取时间选择框
  Widget _storeToTime(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.0),
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
                "预计领取:",
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
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Text(
                      formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  行李件数选择框
  Widget _number(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.0),
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
                "行李件数:",
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
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Text(
                      "2件",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  图片上传按钮
  Widget _picture(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.0),
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
                "行李图片:",
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
              child: RaisedButton(
                onPressed: () {},
                child: Text("图片上传"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  行李备注
  Widget _describeField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30.0),
        right: ScreenUtil().setWidth(100.0),
      ),
      height: ScreenUtil().setHeight(400.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "行李备注:",
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
                  border: OutlineInputBorder(),
                  labelText: "请输入行李备注",
                  alignLabelWithHint: true,
                ),
                maxLength: 140,
                maxLines: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  寄存按钮
  Widget _depositButton() {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(50.0),
        left: ScreenUtil().setWidth(100.0),
        right: ScreenUtil().setWidth(100.0),
      ),
      child: RaisedButton(
        color: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          "寄存",
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(60.0),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
