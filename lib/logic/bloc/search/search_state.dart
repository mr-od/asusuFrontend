part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchUninitialized extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchProductWithQueryLoadedState extends SearchState {
  final List<ProductModel> productsModel;

  const SearchProductWithQueryLoadedState({required this.productsModel});

  @override
  List<Object> get props => [];
}

class SearchProductsWithQueryErrorState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchVendorProductLoadedState extends SearchState {
  final List<ProductModel> productsModel;

  const SearchVendorProductLoadedState({required this.productsModel});

  @override
  List<Object> get props => [];
}

class SearchVendorProductsErrorState extends SearchState {
  @override
  List<Object> get props => [];
}
