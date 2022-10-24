// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:justwallpaper/core/services/api_service/end_points.dart';
//
// import 'dio_helper.dart';
//
// class DioImpl extends DioHelper {
//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: BaseUrl,
//       receiveDataWhenStatusError: true,
//       connectTimeout: 5000,
//     ),
//   );
//
//   @override
//   Future<dynamic> get({
//     String? base,
//     required String endPoint,
//     dynamic data,
//     dynamic query,
//     dynamic options,
//     String? token,
//     String? lang,
//     CancelToken? cancelToken,
//     int? timeOut,
//     bool isMultipart = false,
//   }) async {
//     _checkTimeOutAndSetToDioOptions(timeOut);
//     dio.options.headers = _setHeaders(isMultipart, token, lang);
//     _debugPrintData(endPoint, data, query);
//
//     return await request(
//       call: () async => await dio.get(
//         endPoint,
//         queryParameters: query,
//         options: options,
//         cancelToken: cancelToken,
//       ),
//     );
//   }
//
//   @override
//   Future<dynamic> post({
//     String? base,
//     required String endPoint,
//     dynamic data,
//     dynamic query,
//     String? token,
//     String? lang,
//     ProgressCallback? progressCallback,
//     CancelToken? cancelToken,
//     int? timeOut,
//     bool isMultipart = false,
//   }) async {
//     _checkTimeOutAndSetToDioOptions(timeOut);
//     dio.options.headers = _setHeaders(isMultipart, token, lang);
//     _debugPrintData(endPoint, data, query);
//
//     return await request(
//       call: () async => await dio.post(
//         endPoint,
//         data: data,
//         queryParameters: query,
//         onSendProgress: progressCallback,
//         cancelToken: cancelToken,
//       ),
//     );
//   }
//
//   _checkTimeOutAndSetToDioOptions(timeOut) {
//     if (timeOut != null) {
//       dio.options.connectTimeout = timeOut;
//     }
//   }
//
//   _setHeaders(bool isMultipart, String? token, String? lang) {
//     return {
//       if (isMultipart) 'Content-Type': 'multipart/form-data',
//       if (!isMultipart) 'Content-Type': 'application/json',
//       if (!isMultipart) 'Accept': 'application/json',
//       if (lang != null) 'lang': lang,
//       if (token != null) 'Authorization': token,
//     };
//   }
//
//   _debugPrintData(String endPoint, data, query) {
//     debugPrint('URL => ${dio.options.baseUrl + endPoint}');
//     debugPrint('Header => ${dio.options.headers.toString()}');
//     debugPrint('Body => $data');
//     debugPrint('Query => $query');
//   }
// }
