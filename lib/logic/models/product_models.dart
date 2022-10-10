// // To parse this JSON data, do

// //     final products = productsFromJson(jsonString);

// import 'dart:convert';

// List<ProductModel> productsFromJson(String str) => List<ProductModel>.from(
//     json.decode(str).map((x) => ProductModel.fromJson(x)));

// String productsToJson(List<ProductModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ProductModel {
//   ProductModel(
//       {this.name,
//       this.isActive,
//       this.imgsUrl,
//       this.id,
//       this.description,
//       this.vendorId,
//       this.price,
//       this.color,
//       //  this.gender,
//       //  this.material,
//       this.brand});

//   String? name;
//   String? color;
//   // String gender;
//   String? brand;
//   // String material;
//   bool? isActive;
//   List<String>? imgsUrl;
//   int? id;
//   String? description;
//   int? vendorId;
//   double? price;

//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//         name: json["name"],
//         brand: json["brand"],
//         price: json["price"],
//         isActive: json["is_active"],
//         color: json["color"],
//         // gender: json["gender"],
//         // material: json["material"],
//         imgsUrl: List<String>.from(json["imgs_url"].map((x) => x)),
//         id: json["id"],
//         description: json["description"],
//         vendorId: json["vendor_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "brand": brand,
//         "price": price,
//         "color": color,
//         "is_active": isActive,
//         "imgs_url": List<dynamic>.from(imgsUrl!.map((x) => x)),
//         "id": id,
//         "description": description,
//         "vendor_id": vendorId,
//       };
// }

// To parse this JSON data, do

//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productsFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productsToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  var price;
  ProductModel(
      {this.name,
      this.isActive,
      this.imgsUrl,
      this.id,
      this.description,
      this.owner,
      this.memorySize,
      this.screenSize,
      this.condition,
      this.brand,
      this.price,
      this.sPrice});

  String? name;
  String? description;
  String? condition;
  String? sPrice;
  // double? price;

  bool? isActive;

  int? id;
  String? owner;
  String? brand;
  String? screenSize;
  String? memorySize;
  List<String>? imgsUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      name: json["name"],
      price: double.parse(json["price"]),
      isActive: json["is_active"],
      imgsUrl: List<String>.from(json["imgs_url"].map((x) => x)),
      id: json["id"],
      description: json["description"],
      owner: json["owner"],
      screenSize: json["screen_size"],
      brand: json["brand"],
      memorySize: json["memory_size"],
      condition: json["condition"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_active": isActive,
        "imgs_url": List<dynamic>.from(imgsUrl!.map((x) => x)),
        "id": id,
        "description": description,
        "brand": brand,
        "owner": owner,
        "price": price,
        "memory_size": memorySize,
        "screen_size": screenSize,
        "condition": condition,
      };
}
