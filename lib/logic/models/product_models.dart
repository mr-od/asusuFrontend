import 'dart:convert';

List<ProductModel> productsFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productsToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  // var price;
  ProductModel({
    this.name,
    // this.isActive,
    this.imgsUrl,
    this.id,
    this.description,
    this.owner,
    this.price,
  });

  String? name;
  String? description;
  String? price;

  bool? isActive;

  int? id;
  String? owner;
  List<String>? imgsUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        price: json["price"],
        imgsUrl: List<String>.from(json["imgs_url"].map((x) => x)),
        id: json["id"],
        description: json["description"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        // "is_active": isActive,
        "imgs_url": List<dynamic>.from(imgsUrl!.map((x) => x)),
        "id": id,
        "description": description,
        // "brand": brand,
        "owner": owner,
        "price": price,
        // "memory_size": memorySize,
        // "screen_size": screenSize,
        // "condition": condition,
      };
}
