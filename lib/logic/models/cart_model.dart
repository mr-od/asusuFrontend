import 'package:equatable/equatable.dart';

import '../logic.dart';

class Cart extends Equatable {
  final List<ProductModel> products;

  const Cart({this.products = const <ProductModel>[]});

  @override
  List<Object?> get props => [products];

  Map productQuantity(products) {
    var quantity = {};

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });

    return quantity;
  }

  double get subtotal => products.fold(
      0, (total, current) => total + double.parse(current.price!));

  double deliveryFee(subtotal) {
    if (subtotal >= 500000.0) {
      return 0.0;
    } else {
      return 4999.0;
    }
  }

  String freeDelivery(subtotal) {
    if (subtotal >= 500000.0) {
      return 'You have Free Delivery';
    } else {
      double missing = 500000.0 - subtotal;
      return 'Add ₦${missing.toStringAsFixed(2)} for FREE Delivery';
    }
  }

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);
}
