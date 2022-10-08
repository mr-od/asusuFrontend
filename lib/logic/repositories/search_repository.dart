import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/services/secure_storage.dart';
import '../logic.dart';

abstract class SearchRepository {
  static String mainUrl = "http://afia4.herokuapp.com";
  var searchVendorProducts = '$mainUrl/vendors/products/';
  String? vendorToken;
  var qdata = [];
  List<ProductModel> qresults = [];
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<ProductModel>> searchVProducts(String query);
}

class SearchRepoImpl extends SearchRepository {
  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    var searchVProducts =
        Uri.parse('http://10.0.2.2:8000/search/?keyword=$query');

    await SecureStorage.readSecureData("token")
        .then((value) => vendorToken = value);
    debugPrint('Get Vendor Products with token: $vendorToken');
    var response = await http.get(searchVProducts, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $vendorToken',
    });
    if (response.statusCode != 200) {
      throw Exception('Request Failed; ${response.statusCode}');
    }
    try {
      var data = json.decode(response.body);
      debugPrint('Search data: $data');

      qresults = (data as List).map((x) => ProductModel.fromJson(x)).toList();
      debugPrint('Search qresults: $qresults');
      return qresults;
    } catch (_) {
      throw Exception('Error Parsing Response Body');
    }
  }

  @override
  Future<List<ProductModel>> searchVProducts(String query) async {
    var url = Uri.parse(searchVendorProducts);
    await SecureStorage.readSecureData("token")
        .then((value) => vendorToken = value);
    debugPrint('Get Vendor Products with token: $vendorToken');
    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $vendorToken',
      });
      if (response.statusCode == 200) {
        qdata = json.decode(response.body);
        qresults = qdata.map((e) => ProductModel.fromJson(e)).toList();
        if (query != null) {
          qresults = qresults
              .where((element) =>
                  element.name!.toLowerCase().contains((query.toLowerCase())))
              .toList();
        }
      } else {
        debugPrint("fetch error");
      }
    } on Exception catch (e) {
      debugPrint('error: $e');
    }
    return qresults;
  }

  // Future<List<ProductModel>> searchProduct() async {
  //   await SecureStorage.readSecureData("token")
  //       .then((value) => vendorToken = value);
  //   debugPrint('Get Vendor Products with token: $vendorToken');

  //   try {
  //     final response = await Dio().get(
  //       searchProducts,
  //       options: Options(
  //           headers: {
  //             'Content-Type':
  //                 'application/x-www-form-urlencoded;charset=UTF-8;application/json;multipart/form-data',
  //             'Accept': 'application/json',
  //             "Authorization": "Bearer $vendorToken",
  //           },
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status! < 500;
  //           }),
  //     );
  //     debugPrint(response.toString());
  //     return (response.data as List)
  //         .map((x) => ProductModel.fromJson(x))
  //         .toList();
  //   } on DioError catch (e) {
  //     debugPrint("Status code: ${e.response?.statusCode.toString()}");
  //     throw Exception("Failed to load currently Logged in Vendor Products");
  //   }
  // }
}
