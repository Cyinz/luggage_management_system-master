import 'package:shared_preferences/shared_preferences.dart';

//  行李员
class Clerk {
  //  用户ID
  String id;

  //  用户名
  String username;

  //用户头像
  String img;

  //  用户权限
  int right;

  //  用户所在酒店
  String hotel;

  //  用户登陆状态
  int state;

  //  用户电话
  String phonenumber;

  Clerk(
      {this.id,
      this.username,
      this.img,
      this.right,
      this.hotel,
      this.state,
      this.phonenumber});

  Clerk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    img = json['img'];
    right = json['right'];
    hotel = json['hotel'];
    state = json['state'];
    phonenumber = json['phonenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['img'] = this.img;
    data['right'] = this.right;
    data['hotel'] = this.hotel;
    data['state'] = this.state;
    data['phonenumber'] = this.phonenumber;

    return data;
  }
}

//  保存登陆行李员信息
saveClerk(Clerk clerk) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('clerkId', clerk.id);
  sharedPreferences.setString('clerkUserName', clerk.username);
  sharedPreferences.setString('clerkImg', clerk.img);
  sharedPreferences.setInt('clerkRight', clerk.right);
  sharedPreferences.setString('clerkHotel', clerk.hotel);
  sharedPreferences.setInt('clerkState', clerk.state);
  sharedPreferences.setString('clerkPhoneNumber', clerk.phonenumber);
}

//  退出登录清除行李员信息
clearClerk() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove('clerkId');
  sharedPreferences.remove('clerkUserName');
  sharedPreferences.remove('clerkImg');
  sharedPreferences.remove('clerkRight');
  sharedPreferences.remove('clerkHotel');
  sharedPreferences.remove('clerkState');
  sharedPreferences.remove('clerkPhoneNumber');
}
