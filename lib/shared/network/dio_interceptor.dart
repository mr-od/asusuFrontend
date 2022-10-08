// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager extends Interceptor {
  // 1. Singleton Factory constructor
  //static final CookieManager _instance = CookieManager._internal

  //2. Singleton Static field with getter
  static final TokenManager _instance = TokenManager._internal();
  static TokenManager get instance => _instance;
  TokenManager._internal();

  String? access_token;
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode == 200) {
      var data = Map<String, dynamic>.from(response.data);
      if (data['set-token'] != null) {
        saveToken(data['access_token']);
      }
    } else if (response.statusCode == 401) {
      clearToken();
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // options.headers['access_token'] = access_token;
    // options.headers['Authorization'] = "Bearer ${access_token}";
    options.headers['Authorization'] = "Bearer $access_token";

    return super.onRequest(options, handler);
  }

  Future<void> initToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString('token');
    debugPrint('current token: $access_token');
  }

  void saveToken(String Token) async {
    if (access_token != Token) {
      access_token = Token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', access_token!);
      debugPrint('new: $Token');
    }
  }

  final _storage = FlutterSecureStorage();

  Future saveSecureToken(String token) async {
    await _storage.write(key: "vt", value: token);
    debugPrint('writeSecure: $token');
  }

  Future readSecureToken(String key) async {
    await _storage.read(key: key);
    debugPrint('readSecure: $key');
  }

  void clearToken() async {
    access_token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
  }
}
