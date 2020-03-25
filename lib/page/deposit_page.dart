import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luggagemanagementsystem/provide/deposit_form.dart';
import 'package:provide/provide.dart';

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
            // 点击空白处收回键盘
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          );
        },
      ),
    );
  }

  //  寄存表单
  Widget _depositForm(BuildContext context) {
    return Form(
      child: ListView(
        key: Provide.value<DepositForm>(context).depositFormKey,
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
          _locationField(context),
          _genderRadio(context),
          _storeToTime(context),
          _number(context),
          _pictureBtn(context),
          _picture(context),
          _describeField(context),
        ],
      ),
    );
  }

  //  表单标题
  Widget _formTitle() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(30.0)),
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
                  Provide.value<DepositForm>(context).setSaverName(value);
                },
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
            child: Container(
              margin: EdgeInsets.only(left: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                  border: OutlineInputBorder(),
                  hintText: '请输入客户手机号',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
                onSaved: (value) {
                  Provide.value<DepositForm>(context).setPhone(value);
                },
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
            child: Container(
              margin: EdgeInsets.only(left: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                  border: OutlineInputBorder(),
                  hintText: '请输入行李绑定标签号',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
                onSaved: (value) {
                  Provide.value<DepositForm>(context).setTag(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  行李位置输入框
  Widget _locationField(BuildContext context) {
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
                "行李位置:",
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
                  hintText: '请输入行李位置',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
                onSaved: (value) {
                  Provide.value<DepositForm>(context).setLocation(value);
                },
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
                  groupValue: Provide.value<DepositForm>(context).gender,
                  onChanged: (value) {
                    Provide.value<DepositForm>(context).setGender(value);
                  },
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
                  groupValue: Provide.value<DepositForm>(context).gender,
                  onChanged: (value) {
                    Provide.value<DepositForm>(context).setGender(value);
                  },
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
                onTap: () {
                  showPickerDateTime(context);
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      Provide.value<DepositForm>(context).storeToTime,
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
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(500),
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                        LengthLimitingTextInputFormatter(2) //限制长度
                      ],
                    ),
                  ),
                  Text("件")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  图片上传按钮
  Widget _pictureBtn(BuildContext context) {
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
                onPressed: () {
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
                child: Text("图片上传"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  图片
  Widget _picture(BuildContext context) {
    return Center(
      child: Provide.value<DepositForm>(context).pic == null
          ? SizedBox()
          : Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(180), top: 5),
              height: ScreenUtil().setHeight(400),
              width: ScreenUtil().setWidth(600),
              child: Image.file(
                Provide.value<DepositForm>(context).pic,
                width: ScreenUtil().setWidth(500),
              ),
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
      height: ScreenUtil().setHeight(300.0),
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
                  contentPadding: EdgeInsets.only(top: 5, left: 10),
                  border: OutlineInputBorder(),
                  hintText: "请输入行李备注",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: ScreenUtil().setSp(40),
                  ),
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

  //  选择时间插件
  showPickerDateTime(BuildContext context) {
    new Picker(
      adapter: new DateTimePickerAdapter(
        type: PickerDateTimeType.kYMDHMS,
        isNumberMonth: true,
        yearSuffix: "年",
        monthSuffix: "月",
        daySuffix: "日",
        minValue: DateTime.now(),
        minuteInterval: 1,
      ),
      title: new Text("预计领取时间"),
      textAlign: TextAlign.right,
      selectedTextStyle: TextStyle(color: Colors.blue),
      delimiter: [
        PickerDelimiter(
          column: 4,
          child: Container(
            width: 16.0,
            alignment: Alignment.center,
            child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
            color: Colors.white,
          ),
        ),
        PickerDelimiter(
          column: 6,
          child: Container(
            width: 16.0,
            alignment: Alignment.center,
            child: Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
            color: Colors.white,
          ),
        ),
      ],
//        footer: Container(
//          height: 50.0,
//          alignment: Alignment.center,
//          child: Text('Footer'),
//        ),
      onConfirm: (Picker picker, List value) {
        Provide.value<DepositForm>(context).setStoreToTime(formatDate(
            DateTime.parse(picker.adapter.toString()),
            [yyyy, '-', mm, '-', dd, " ", HH, ":", nn, ":", ss]));
      },
//        onSelect: (Picker picker, int index, List<int> selecteds) {
////          this.setState(() {
////            stateText = picker.adapter.toString();
////          });
//        Provide.value<DepositForm>(context).setStoreToTime(picker.adapter.text);
//        }
    ).showModal(context);
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
    Provide.value<DepositForm>(context).setPic(image);
  }

  //  通过相册获取图片
  Future getImageByGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Provide.value<DepositForm>(context).setPic(image);
  }
}
