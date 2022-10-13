import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../logic.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepo;

  ProductBloc({required this.productRepo}) : super(ProductLoadingState()) {
    on<LoadProductEvent>(_loadProductDetail);
    on<FetchPromotedProductsEvent>(_loadPromotedProducts);
  }

  FutureOr<void> _loadProductDetail(
      LoadProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      await Future.delayed(const Duration(milliseconds: 0));
      emit(ProductLoadedState(event.loadProductModel));
    } catch (e) {
      emit(ProductErrorState(event.loadProductModel));
    }
  }

  FutureOr<void> _loadPromotedProducts(
      FetchPromotedProductsEvent event, Emitter<ProductState> emit) async {
    emit(PromotedProductLoadingState());
    try {
      final product = await productRepo.fetchPromotedProducts();
      emit(PromotedProductLoadedState(productModel: product));
    } catch (error) {
      emit(PromotedProductErrorState(error: error.toString()));
    }
  }
}
