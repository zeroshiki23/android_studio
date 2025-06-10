import 'dart:convert';

import 'package:dio/dio.dart';

abstract class ApiClient{
  final Dio _dio = Dio();
  
  ApiClient(){
    _dio.options.headers['content-Type'] = 'appLication/json';
    _dio.options.baseUrl = 'http://10.0.2.2:0000/api/';
  }
  
  Dio get dio => _dio;
}