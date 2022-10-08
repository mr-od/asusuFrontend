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
      try {
        emit(ProductLoadingState());
        await Future.delayed(const Duration(milliseconds: 500));
        emit(ProductLoadedState(event.loadProductModel));
      } catch (e) {
        emit(ProductErrorState(event.loadProductModel));
      }
    });

    on<FetchPromotedProductsEvent>((event, emit) async {
      try {
        emit(PromotedProductLoadingState());

        final currentVendor = await productRepo.fetchPromotedProducts();

        emit(PromotedProductLoadedState(productModel: currentVendor));

        debugPrint('Vendor Product Loaded : $PromotedProductLoadingState()');
      } catch (error) {
        emit(PromotedProductErrorState(error: error.toString()));
      }
    });
  }
}
