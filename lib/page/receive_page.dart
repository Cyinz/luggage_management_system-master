import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("行李领取"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              height: ScreenUtil().setHeight(100.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "请输入取行李码",
                  prefixIcon: IconButton(
                    icon: Icon(MaterialCommunityIcons.qrcode_scan),
                    onPressed: () {},
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(20, 150, 20, 0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "订单编号:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("61b52136-c4b9-11e9-8e5d-3753fbf1c60c"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Image.network(
                          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584214735946&di=68bf93a1c61da6e03c8b9bac9d6497da&imgtype=0&src=http%3A%2F%2Fimg.jk51.com%2Fimg_jk51%2F93051887.jpeg",
                          width: ScreenUtil().setWidth(400),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("客户姓名:  金先生"),
                            Text("客户电话:  13631218312"),
                            Text("寄存时间:  2019-7-29"),
                            Text("预计领取:  2019-7-30"),
                            Text("行李备注:  "),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(200.0),
                        left: ScreenUtil().setWidth(100.0),
                        right: ScreenUtil().setWidth(100.0),
                      ),
                      child: RaisedButton(
                        color: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          "确认领取",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(60.0),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
