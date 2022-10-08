part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({this.cart = const Cart()});

  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  @override
  List<Object> get props => [];
}

class PlacingOrderState extends CartState {
  @override
  List<Object> get props => [];
}

class OrderSuccessState extends CartState {
  @override
  List<Object> get props => [];
}

class OrderPlacingFailureState extends CartState {
  final String error;

  const OrderPlacingFailureState({required this.error});

  @override
  List<Object> get props => [error];
}
