import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../shared/services/secure_storage.dart';
import '../logic.dart';

abstract class ProductRepository {
  static String mainUrl = "http://10.0.2.2:8000";
  var promotedProducts = '$mainUrl/products/promoted';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  // final Dio _dio = Dio();

  final secureStorage = SecureStorage();
  String? vendorToken;
  String? finalToken;

  Future<List<ProductModel>> fetchPromotedProducts();
}

class ProductRepoImpls extends ProductRepository {
  @override
  Future<List<ProductModel>> fetchPromotedProducts() async {
    await SecureStorage.readSecureData("token")
        .then((value) => finalToken = value);
    debugPrint('Get Vendor Products with token: $finalToken');

    try {
      final response = await Dio().get(
        promotedProducts,
        options: Options(
            headers: {
              'Content-Type':
                  'application/x-www-form-urlencoded;charset=UTF-8;application/json;multipart/form-data',
              'Accept': 'application/json',
              "Authorization": "Bearer $finalToken",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      // debugPrint('Promoted Products Repository Says ${response.toString()}');
      debugPrint('Promoted Products Repository Says $response');
      final og =
          (response.data as List).map((x) => ProductModel.fromJson(x)).toList();

      debugPrint('Og $og');

      return og;
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to load currently Logged in Vendor Products");
    }
  }
}
