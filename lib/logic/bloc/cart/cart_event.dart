// ignore_for_file: non_constant_identifier_names

part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddProduct extends CartEvent {
  final ProductModel product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProduct extends CartEvent {
  final ProductModel product;

  const RemoveProduct(this.product);

  @override
  List<Object> get props => [product];
}

class PlaceOrderButtonPressed extends CartEvent {
  final List<ProductQuantity>? productQuantity;
  final double subtotal;
  final double total;
  final double deliveryFee;

  const PlaceOrderButtonPressed(
      {required this.productQuantity,
      required this.subtotal,
      required this.total,
      required this.deliveryFee});

  @override
  List<Object> get props => [subtotal, total, deliveryFee];
}
