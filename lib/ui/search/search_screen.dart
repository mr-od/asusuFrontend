import 'package:asusu_igbo_f/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';

class SearchProducts extends SearchDelegate<SearchBloc> {
  SearchBloc sBloc;
  // ProductBloc pBloc;

  var keyword = "";

  SearchProducts({required this.sBloc, required String hintText})
      : super(
          searchFieldLabel: hintText,
        );

// UI Design of Search
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      colorScheme: const ColorScheme.dark(background: amaranth),
      textSelectionTheme: theme.textSelectionTheme.copyWith(
        cursorColor: amaranth,
        selectionColor: amaranth,
      ),
      appBarTheme: theme.appBarTheme.copyWith(backgroundColor: eerieBlack),
      textTheme: theme.textTheme.copyWith(
        headline6: const TextStyle(
            // textBaseline: TextBaseline.ideographic,
            fontWeight: FontWeight.normal,
            color: lavenderBlush), // query Color
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        constraints: const BoxConstraints(minWidth: 150, maxHeight: 30),
        helperStyle: const TextStyle(
            fontSize: 4,
            color: Colors.grey,
            fontFamily: "FiraCode",
            fontWeight: FontWeight.normal),
        border: InputBorder.none,
        filled: true,
        // isDense: true,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: amaranth),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: lavenderBlush),
            borderRadius: BorderRadius.circular(10.0)),
        // contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor: smokyBlack,

        // Use this change the placeholder's text style
        hintStyle: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontFamily: "FiraCode",
            fontWeight: FontWeight.normal),
      ),
    );
  }

  // If you want to add custom Stuff like previous search to the appbar///
  // @override
  // PreferredSizeWidget buildBottom(BuildContext context) {
  //   return const PreferredSize(
  //       preferredSize: Size.fromHeight(30.0), child: Text('bottom'));
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/icons/A4logo.png'),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    keyword = query;
    sBloc.add(SearchProductsWithQueryEvent(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchUninitialized) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchProductsWithQueryErrorState) {
          return const Center(
            child: Text('Product not Found'),
          );
        }
        if (state is SearchProductWithQueryLoadedState) {
          if (state.productsModel.isEmpty) {
            return const Center(
              child: Text('Not Found'),
            );
          }
          return _searchProducts(state.productsModel);
        }
        return const Scaffold();
      },
    );
  }

  Widget _searchProducts(List<ProductModel> productModel) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, index) => productCard(productModel[index], _),
      itemCount: productModel.length,
    );
  }

  InkWell productCard(ProductModel product, BuildContext _) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ProductBloc>(_).add(LoadProductEvent(product));
        Navigator.of(_).pushNamed("/productDetail");
      },
      child: Card(
        elevation: 20,
        color: smokyBlack,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    product.imgsUrl![0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                product.name!,
                style: const TextStyle(color: lavenderBlush),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "\$${product.price.toString()}",
                      style: Theme.of(_).textTheme.caption!.copyWith(
                          color: amaranth, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Sold: 10",
                      style: Theme.of(_).textTheme.caption!.copyWith(
                          color: amaranth, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search Products'),
    );
  }
}
