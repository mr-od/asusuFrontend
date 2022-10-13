part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchProductsWithQueryEvent extends SearchEvent {
  final String query;

  const SearchProductsWithQueryEvent({required this.query});

  @override
  List<Object> get props => [];
}

class SearchVendorProductsEvent extends SearchEvent {
  final String query;

  const SearchVendorProductsEvent({required this.query});
  @override
  List<Object> get props => [];
}
