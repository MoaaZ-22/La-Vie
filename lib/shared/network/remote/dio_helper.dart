import 'package:dio/dio.dart';

class DioHelper {
  // Create Object From Dio
  static late Dio dio;

  // Initial Value For Dio
  static init() {
    dio = Dio(
      // Here Base Url
        BaseOptions(

          // https://lavie.orangedigitalcenteregypt.com
          // base Url For La Vie
            baseUrl: 'https://lavie.orangedigitalcenteregypt.com',
            receiveDataWhenStatusError: true,
            headers: {'Content-Type': 'application/json'}));
  }

  //Function For Get Data
  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken
      })
  async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'

    };
    return await dio.get(url, queryParameters: query,);
  }



  // Function For Post Data
  static Future<Response> postData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.post(
        url,
        queryParameters: query,
        data: data
    );
  }

  // Function For Post Data
  static Future<Response> postWithoutData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
       }) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.post(
        url,
        queryParameters: query,
    );
  }

  // Function For Update User Data
  static Future<Response> putData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.put(
        url,
        queryParameters: query,
        data: data
    );
  }


  // Function For Update User Data (patch)
  static Future<Response> patchData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.patch(
        url,
        queryParameters: query,
        data: data
    );
  }
}
