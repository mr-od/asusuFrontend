// To parse this JSON data, do
//
//     final checkout = checkoutFromMap(jsonString);

import 'dart:convert';

class Checkout {
  Checkout({
    this.productQuantity,
    this.orderDetails,
  });

  List<ProductQuantity>? productQuantity;
  OrderDetails? orderDetails;

  factory Checkout.fromJson(String str) => Checkout.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Checkout.fromMap(Map<String, dynamic> json) => Checkout(
        productQuantity: json["productQuantity"] == null
            ? null
            : List<ProductQuantity>.from(
                json["productQuantity"].map((x) => ProductQuantity.fromMap(x))),
        orderDetails: json["order_details"] == null
            ? null
            : OrderDetails.fromMap(json["order_details"]),
      );

  Map<String, dynamic> toMap() => {
        "productQuantity": productQuantity == null
            ? null
            : List<dynamic>.from(productQuantity!.map((x) => x.toMap())),
        "order_details": orderDetails == null ? null : orderDetails!.toMap(),
      };
}

class OrderDetails {
  OrderDetails({
    this.subtotal,
    this.deliveryFee,
    this.total,
  });

  int? subtotal;
  int? deliveryFee;
  int? total;

  factory OrderDetails.fromJson(String str) =>
      OrderDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderDetails.fromMap(Map<String, dynamic> json) => OrderDetails(
        subtotal: json["subtotal"],
        deliveryFee: json["delivery_fee"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "subtotal": subtotal,
        "delivery_fee": deliveryFee,
        "total": total,
      };
}

class ProductQuantity {
  ProductQuantity({
    this.productId,
    this.quantity,
  });

  int? productId;
  int? quantity;

  factory ProductQuantity.fromJson(String str) =>
      ProductQuantity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductQuantity.fromMap(Map<String, dynamic> json) => ProductQuantity(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
