import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luggagemanagementsystem/provide/update_form.dart';
import 'package:luggagemanagementsystem/router/application.dart';
import 'package:luggagemanagementsystem/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initForm(context);
    ScreenUtil.init(context, width: 1080, height: 1980);
    return Scaffold(
      appBar: AppBar(
        title: Text("修改个人资料"),
        centerTitle: true,
      ),
      body: Provide<UpdateForm>(
        builder: (context, child, updateForm) {
          return GestureDetector(
            child: ListView(
              children: <Widget>[
                _updateForm(context),
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

  //  修改个人信息表单
  Widget _updateForm(BuildContext context) {
    return Form(
      key: Provide.value<UpdateForm>(context).updateFormKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        children: <Widget>[
          _image(context),
          _userLoginName(context),
          _userName(context),
          _phone(context),
          _id(context),
          _hotel(context),
          _updateBtn(context),
        ],
      ),
    );
  }

  //  头像
  Widget _image(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: InkWell(
        onTap: () {
          showDemoActionSheet(
            context: context,
            child: CupertinoActionSheet(
              title: const Text('图片上传'),
              message: const Text('请选择提供行李图片'),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: const Text('图库选择'),
                  onPressed: () {
                    Navigator.pop(context, 'Gallery');
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text('拍照上传'),
                  onPressed: () {
                    Navigator.pop(context, 'Camera');
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text('取消'),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
              ),
            ),
          );
        },
        child: Provide.value<UpdateForm>(context).image == null
            ? CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 80.0,
                child: Container(
                  child: Text(
                    "点击上传图片",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 80.0,
                child: Container(
                  child: Image.file(
                    Provide.value<UpdateForm>(context).image,
                  ),
                ),
              ),
      ),
    );
  }

  //  登陆账号
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
                  Provide.value<UpdateForm>(context).setUserLoginName(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  姓名
  Widget _userName(BuildContext context) {
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
                "姓名:",
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
                initialValue: Provide.value<UpdateForm>(context).username,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  Provide.value<UpdateForm>(context).setUsername(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  电话
  Widget _phone(BuildContext context) {
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
                "联系电话:",
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
                initialValue: Provide.value<UpdateForm>(context).phone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  Provide.value<UpdateForm>(context).setPhone(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  工号
  Widget _id(BuildContext context) {
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
                "工号:",
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
                initialValue: Provide.value<UpdateForm>(context).id,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  Provide.value<UpdateForm>(context).setId(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  所属酒店
  Widget _hotel(BuildContext context) {
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
                "所属酒店:",
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
                initialValue: Provide.value<UpdateForm>(context).hotel,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  Provide.value<UpdateForm>(context).setHotel(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  修改按钮
  Widget _updateBtn(BuildContext context) {
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
        onPressed: Provide.value<UpdateForm>(context).isDisabled
            ? null
            : () {
                if (Provide.value<UpdateForm>(context)
                    .updateFormKey
                    .currentState
                    .validate()) {
                  Provide.value<UpdateForm>(context)
                      .updateFormKey
                      .currentState
                      .save();
                  var flag = true;
                  if (Provide.value<UpdateForm>(context).userLoginName ==
                          null ||
                      Provide.value<UpdateForm>(context).userLoginName == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "登陆账号不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (Provide.value<UpdateForm>(context).username == null ||
                      Provide.value<UpdateForm>(context).username == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "姓名不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (Provide.value<UpdateForm>(context).phone == null ||
                      Provide.value<UpdateForm>(context).phone == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "联系电话不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (Provide.value<UpdateForm>(context).id == null ||
                      Provide.value<UpdateForm>(context).id == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "工号不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (Provide.value<UpdateForm>(context).hotel == null ||
                      Provide.value<UpdateForm>(context).hotel == "") {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "所属酒店不能为空",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (Provide.value<UpdateForm>(context).image == null) {
                    flag = false;
                    Fluttertoast.showToast(
                      msg: "请上传人脸图片",
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (flag == false) {
                    Provide.value<UpdateForm>(context).setIsDisabled(false);
                  } else {
                    //  修改
                    updateMsg(context);
                  }
                }
              },
      ),
    );
  }

  initForm(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Provide.value<UpdateForm>(context)
        .setUsername(sharedPreferences.getString('clerkUserName'));
    Provide.value<UpdateForm>(context)
        .setId(sharedPreferences.getString('clerkId'));
    Provide.value<UpdateForm>(context)
        .setRight(sharedPreferences.getInt('clerkRight'));
    Provide.value<UpdateForm>(context)
        .setState(sharedPreferences.getInt('clerkState'));
    Provide.value<UpdateForm>(context)
        .setHotel(sharedPreferences.getString('clerkHotel'));
    Provide.value<UpdateForm>(context)
        .setPhone(sharedPreferences.getString('clerkPhoneNumber'));
  }

  //  选择上传图片方式弹窗
  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        if (value == "Camera") {
          getImageByCamera(context);
        } else if (value == "Gallery") {
          getImageByGallery(context);
        }
      }
    });
  }

  //  通过拍照获取图片
  Future getImageByCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    Provide.value<UpdateForm>(context).setImage(image);
  }

  //  通过相册获取图片
  Future getImageByGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Provide.value<UpdateForm>(context).setImage(image);
  }

  updateMsg(BuildContext context) async {
    String path = Provide.value<UpdateForm>(context).image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      'username': Provide.value<UpdateForm>(context).username,
      'userloginname': Provide.value<UpdateForm>(context).userLoginName,
      'right': Provide.value<UpdateForm>(context).right,
      'imagebig': await MultipartFile.fromFile(path, filename: name),
      'hotel': Provide.value<UpdateForm>(context).hotel,
      'id': Provide.value<UpdateForm>(context).id,
      'state': Provide.value<UpdateForm>(context).state,
      'phonenumber': Provide.value<UpdateForm>(context).phone,
    });
    postRequest('updateMsg', formData: formData).then(
      (data) {
        //  修改成功
        if (data['status'] == 200) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Container(
                child: AlertDialog(
                  title: Text("修改成功"),
                  content: Text("修改成功，请重新登陆"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Provide.value<UpdateForm>(context)
                              .setIsDisabled(false);
                          Application.router.navigateTo(
                            context,
                            '/',
                            replace: true,
                            clearStack: true,
                          );
                        },
                        child: Text("确认"))
                  ],
                ),
              );
            },
          );
        }
        //  修改失败
        else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Container(
                child: AlertDialog(
                  title: Text("修改失败"),
                  content: Text("用户信息修改失败，请检查"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Provide.value<UpdateForm>(context)
                            .updateFormKey
                            .currentState
                            .reset();
                        Provide.value<UpdateForm>(context).setIsDisabled(false);
                        Navigator.pop(context);
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
}
