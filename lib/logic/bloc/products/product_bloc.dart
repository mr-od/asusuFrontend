import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../logic.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepo;

  ProductBloc({required this.productRepo}) : super(ProductInitialState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        await Future.delayed(const Duration(milliseconds: 0));
        emit(ProductLoadedState(event.loadProductModel));
      } catch (e) {
        emit(ProductErrorState(event.loadProductModel));
      }
    });

    on<FetchPromotedProductsEvent>((event, emit) async {
      emit(PromotedProductLoadingState());
      try {
        final currentVendor = await productRepo.fetchPromotedProducts();

        emit(PromotedProductLoadedState(productModel: currentVendor));
      } catch (error) {
        emit(PromotedProductErrorState(error: error.toString()));
      }
    });
  }
}
