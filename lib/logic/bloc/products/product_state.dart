part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  final ProductModel productBlocModel;

  const ProductErrorState(this.productBlocModel);
}

class ProductLoadedState extends ProductState {
  final ProductModel productBlocModel;

  const ProductLoadedState(this.productBlocModel);
}

class PromotedProductLoadingState extends ProductState {}

class WaitWhileProductisLoadingState extends ProductState {}

class PromotedProductLoadedState extends ProductState {
  final List<ProductModel> productModel;

  const PromotedProductLoadedState({required this.productModel});

  @override
  List<Object> get props => [productModel];
}

class PromotedProductErrorState extends ProductState {
  final String error;

  const PromotedProductErrorState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Product Loading Failure {$error}';
}
