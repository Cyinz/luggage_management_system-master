import 'package:dio/dio.dart';
import 'package:luggagemanagementsystem/config/service_url.dart';

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

Future postRequest(url, {formData}) async {
  try {
    print("开始获取数据......");
    Response response;
    Dio dio = new Dio();
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
