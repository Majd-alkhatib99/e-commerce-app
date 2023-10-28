import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'http://192.168.43.142:8000/api/',
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
    String? token,
  })async
  {
    dio!.options.headers={

      'Authorization':'Bearer $token',
      'Content-Type':'application/json'
    };
    return await dio!.get(
        url,
        queryParameters: query
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,

    String? token,

  })async{
    dio!.options.headers={
      'Authorization':'Bearer $token',
      'Content-Type':'application/json'
    };
    return await dio!.post(
        url,
        data: data,
        queryParameters: query
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json'
    };
    return await dio!.put(
        url,
        data: data,
        queryParameters: query

    );
  }

}