import 'package:dio/dio.dart';

import '../../components/constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.pexels.com/v1/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en-US',
    String? token = token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
      'X-Ratelimit-Limit': '200000',
      'X-Ratelimit-Remaining': '190684',
      'X-Ratelimit-Reset': '1590529646',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> searchPhotos({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en-US',
    String? token = token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token = token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
