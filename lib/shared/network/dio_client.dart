import 'package:dio/dio.dart';

import '../services/secure_storage.dart';

class DioS {
  static Dio dio = Dio();
}

class DioClient {
  var dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000",
      receiveDataWhenStatusError: true,
    ),
  );

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  final secureStorage = SecureStorage();
  String? postDataMFDToken;

  Future<Response> postDataMFD({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    await SecureStorage.readSecureData("token")
        .then((value) => postDataMFDToken = value);
    print('Add product with token: $postDataMFDToken');

    // dio.options.headers = {
    //   'lang': lang,
    //   'Authorization': token ?? '',
    //   'Content-Type': 'application/json',
    // };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'accept': 'application/json',
            "Authorization": "Bearer $postDataMFDToken",
          },
          followRedirects: true,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

  Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
