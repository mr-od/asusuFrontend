import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../shared/services/secure_storage.dart';
import '../logic.dart';

abstract class UserRepository {
  // static String mainUrl = "http://10.0.2.2:8000";
  static String mainUrl = "http://10.0.2.2:8080";

  var loginurl = '$mainUrl/api/v1/users/login';
  var registerUrl = '$mainUrl/api/v1/users/register';
  var userDetails = '$mainUrl/users/me';
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio _dio = Dio();
  final secureStorage = SecureStorage();
  String? finalToken;
  var qdata = [];

  Future<bool> readToken();
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<void> saveUsername(String email);
  Future<String> login(String email, String password);
  Future<SingleUserModel> getCurrentUser();
}

class UserRepoImpl extends UserRepository {
  @override
  Future<bool> readToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  @override
  Future<void> saveUsername(String username) async {
    await storage.write(key: 'username', value: username);
  }

  @override
  Future<String> login(String username, String password) async {
    var formData =
        FormData.fromMap({"username": username, "password": password});
    Response response = await _dio.post(
      loginurl,
      data: formData,
      options: Options(
          headers: {
            'Content-Type':
                'application/x-www-form-urlencoded;charset=UTF-8;application/json;multipart/form-data',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    return response.data["access_token"];
  }

  @override
  Future<SingleUserModel> getCurrentUser() async {
    await SecureStorage.readSecureData("token")
        .then((value) => finalToken = value);
    debugPrint('Get Vendor with token: $finalToken');
    try {
      final response = await _dio.get(
        userDetails,
        options: Options(
            headers: {
              'Content-Type':
                  'application/x-www-form-urlencoded;charset=UTF-8;application/json;multipart/form-data',
              'Accept': 'application/json',
              "Authorization": "Bearer $finalToken",
            },
            followRedirects: true,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      debugPrint('Backend 200 OK : $response');
      return SingleUserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception('failed to load logged in Vendor');
    }
  }
}
