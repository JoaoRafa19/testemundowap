import 'package:dio/dio.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class BaseGateway {
  final String baseUrl;
  final client = Client();

  BaseGateway(this.baseUrl) {
    client.dio = client.init(baseUrl);
  }
}

class Client {
  late Dio dio;

  Dio init(String baseUrl) {
    dio = Dio();
    dio.interceptors.add(ApiInterceptors());
    dio.options.headers.addAll({
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    dio.options.baseUrl = baseUrl;
    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {}

  @override
  Future<dynamic> onResponse(Response response, handler) async {
    if (response.statusCode == 200) {
      debugPrint("RESPONSE--------->");
      debugPrint(response.data);
      debugPrint("<--------------------");
    }
    return response;
  }
}
