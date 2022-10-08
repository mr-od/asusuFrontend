import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../shared/services/secure_storage.dart';
import '../logic.dart';

// abstract class CheckoutRepository {
//   static String mainUrl = "http://10.0.2.2:8000";
//   var placeOrderUrl = '$mainUrl/orders/place/';
//   final FlutterSecureStorage storage = const FlutterSecureStorage();
//   final Dio _dio = Dio();
//   final secureStorage = SecureStorage();
//   String? finalToken;
//   var qdata = [];

//   Future<Checkout> placeOrder(List<Ao>? aos, OrderDetails orderDetails);
// }

class CheckoutRepository {
  static String mainUrl = "http://10.0.2.2:8000";
  var placeOrderUrl = '$mainUrl/orders/place/';
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio _dio = Dio();
  final secureStorage = SecureStorage();
  String? finalToken;
  var qdata = [];

  // @override
  Future<void> placeOrder(List<ProductQuantity>? productQuantity,
      double subtotal, double deliveryFee, double total) async {
    await SecureStorage.readSecureData("token")
        .then((value) => finalToken = value);
    debugPrint('Place Order With Token: $finalToken');

    try {
      Map<String, dynamic> cartData = {
        "productQuantity": jsonEncode(productQuantity),
        "order_details": {
          "subtotal": subtotal,
          "delivery_fee": deliveryFee,
          "total": total
        }
      };

      Response response = await _dio.post(
        placeOrderUrl,
        options: Options(
          headers: {
            'Content-Type':
                'application/x-www-form-urlencoded;charset=UTF-8;application/json;multipart/form-data',
            'Accept': 'application/json',
            "Authorization": "Bearer $finalToken",
          },
        ),
        data: cartData,
      );
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception('Failed to place order');
    }
  }
}
