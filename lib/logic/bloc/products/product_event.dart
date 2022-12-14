part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductEvent extends ProductEvent {
  final ProductModel loadProductModel;

  const LoadProductEvent(this.loadProductModel);
  @override
  List<Object> get props => [loadProductModel];
}

////////////// Fetch Promoted Products for the HomeScreen ////////////////
class FetchPromotedProductsEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}
