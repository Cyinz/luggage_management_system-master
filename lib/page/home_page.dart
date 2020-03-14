import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/provide/home_drawer.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1980);
    getClerk(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("智能酒店行李管理"),
        centerTitle: true,
      ),
      drawer: Provide<HomeDrawer>(
        builder: (context, child, homeDrawer) {
          return Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    Provide.value<HomeDrawer>(context).clerkName,
                  ),
                  accountEmail: Text(
                    Provide.value<HomeDrawer>(context).clerkHotel,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
//                      Provide.value<HomeDrawer>(context).clerkImg,
                      "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=430089504,3674027973&fm=26&gp=0.jpg",
                    ),
                    backgroundColor: Colors.grey[400],
                    radius: 40.0,
                  ),
                ),
                //  占满剩余空间
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Divider(
                    height: 1,
                    color: Colors.grey[500],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("退出登陆"),
                  onTap: () {},
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(ScreenUtil.bottomBarHeight),
                ),
              ],
            ),
          );
        },
      ),
      body: Center(
        child: Text("HomePage"),
      ),
    );
  }

  //  加载行李员信息
  getClerk(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Provide.value<HomeDrawer>(context)
        .setClerkId(sharedPreferences.getString('clerkId'));
    Provide.value<HomeDrawer>(context)
        .setClerkName(sharedPreferences.getString('clerkUserName'));
    Provide.value<HomeDrawer>(context)
        .setClerkImg(sharedPreferences.getString('clerkImg'));
    Provide.value<HomeDrawer>(context)
        .setClerkHotel(sharedPreferences.getString('clerkHotel'));
  }
}
