import 'package:dio/dio.dart';
import 'package:dummy_api/core/api/network_handlers.dart';
import 'package:dummy_api/core/constant/b7c_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class BaseApi {
  final client = http.Client();
  final dio = createDio();
  BaseApi._internal();
  static final _singleton = BaseApi._internal();

  factory BaseApi() => _singleton;

  static Dio createDio() {
    debugPrint(
      'Request : ${B7CConstants.baseUrl} ',
    );
    var dio = Dio(BaseOptions(
      baseUrl: B7CConstants.baseUrl,
      headers: B7CConstants.appIdHeaders,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));
    dio.interceptors.addAll({
      Network(dio),
    });
    return dio;
  }
}
