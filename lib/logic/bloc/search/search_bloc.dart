import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../logic.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepo;
  SearchBloc({required this.searchRepo}) : super(SearchUninitialized()) {
    on<SearchProductsWithQueryEvent>((event, emit) async {
      emit(SearchUninitialized());

      try {
        final productModel = await searchRepo.searchProducts(event.query);
        emit(SearchProductWithQueryLoadedState(productsModel: productModel));
      } catch (e) {
        emit(SearchProductsWithQueryErrorState());
      }
    });
    on<SearchVendorProductsEvent>((event, emit) async {
      emit(SearchUninitialized());
      try {
        List<ProductModel> productModel =
            await searchRepo.searchVProducts(event.query);
        emit(SearchVendorProductLoadedState(productsModel: productModel));
      } catch (e) {
        emit(SearchVendorProductsErrorState());
      }
    });
  }
}
