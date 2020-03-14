import 'package:dio/dio.dart';
import 'package:luggagemanagementsystem/config/service_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  GET网络请求
Future getRequest(url) async {
  try {
    print("开始获取数据......");
    Response response;
    Dio dio = new Dio();
    response = await dio.get(servicePath[url]);

    //  网络请求成功
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常......");
    }
  } catch (e) {
    return print("错误信息:${e}");
  }
}

//  POST网络请求
Future postRequest(url, {formData}) async {
  try {
    print("开始获取数据......");
    Response response;
    Dio dio = new Dio();
    //  是否带参数
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    //  网络请求成功
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常......");
    }
  } catch (e) {
    return print("错误信息: ${e}");
  }
}

//  保存登陆Token
saveToken(String value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('Token', value);
}

//  清空Token
clearToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove('Token');
}

//  验证Token是否过期
bool checkToken(String value) {
  FormData formData = FormData.fromMap({
    'token': value,
  });
  postRequest('checkToken', formData: formData).then((data) {
    if (data['status'] == 200) {
      return true;
    } else {
      return false;
    }
  });
}
