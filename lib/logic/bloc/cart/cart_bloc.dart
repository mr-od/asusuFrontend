import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../logic.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CheckoutRepository checkoutRepo = CheckoutRepository();
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<PlaceOrderButtonPressed>(_placeOrder);
  }

  void _onLoadCart(
    LoadCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((state as CartLoaded).cart.products)
                ..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((state as CartLoaded).cart.products)
                ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }

  FutureOr<void> _placeOrder(
      PlaceOrderButtonPressed event, Emitter<CartState> emit) async {
    emit(PlacingOrderState());
    try {
      await checkoutRepo.placeOrder(event.productQuantity, event.subtotal,
          event.total, event.deliveryFee);

      emit(OrderSuccessState());
    } catch (error) {
      emit(OrderPlacingFailureState(error: error.toString()));
    }
  }
}
