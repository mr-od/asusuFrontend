import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';
import '../../shared/shared.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../ui.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductBloc bloc;
  late CartBloc cBloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ProductBloc>(context);
    cBloc = BlocProvider.of<CartBloc>(context);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   bloc.close();
  //   cBloc.close();
  // }

  bool _addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: a4_style.eerieBlack,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: SafeArea(
                  child: AppBar(
                    flexibleSpace: searchFormField(
                      label: "Search",
                      prefix: "assets/icons/A4logo.png",
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: SearchProducts(
                                hintText: 'Search Products',
                                sBloc: BlocProvider.of<SearchBloc>(context)));
                      },
                    ),
                    backgroundColor: a4_style.eerieBlack,
                  ),
                )),
            body: SingleChildScrollView(
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (BuildContext context, ProductState state) {
                if (state is ProductLoadingState) {
                  return _loading();
                } else if (state is ProductErrorState) {
                  return _loadingErrorWidget(context, state.productBlocModel);
                } else if (state is ProductLoadedState) {
                  return _productDetail(state.productBlocModel);
                } else {
                  return Center(child: Text('The state is : $state'));
                }
              }),
            ),
            bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
              if (state is ProductLoadedState) {
                debugPrint('Product Ready to add to cart : $state');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buyNowButton(),
                    add2CartButton(state.productBlocModel),
                  ],
                );
              } else {
                return Container();
              }
            })),
      ),
    );
  }

  Expanded buyNowButton() {
    return Expanded(
        child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: a4_style.pureBlack,
        side: const BorderSide(color: a4_style.amaranth),
        shape: const RoundedRectangleBorder(),
      ),
      child: const Text("Buy Now", style: TextStyle(color: lavenderBlush)),
    ));
  }

  Expanded add2CartButton(ProductModel productM) {
    return Expanded(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const CircularProgressIndicator();
          }
          if (state is CartLoaded) {
            return ElevatedButton(
              onPressed: () {
                if (_addedToCart == false) {
                  context.read<CartBloc>().add(AddProduct(productM));

                  Navigator.of(context).pushNamed('/cart');
                  setState(() {
                    _addedToCart = true;
                  });
                }
                if (_addedToCart == true) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                            value: cBloc,
                            child: const CartScreen(),
                          )));
                }
              },
              style: ElevatedButton.styleFrom(
                primary: a4_style.pureBlack,
                shape: const RoundedRectangleBorder(),
                side: const BorderSide(color: a4_style.amaranth),
              ),
              child: Text(
                _addedToCart ? 'View Cart' : 'Add To Cart',
                style: const TextStyle(color: lavenderBlush),
              ),
            );
          }
          return const Text('Error Loading Cart!');
        },
      ),
    );
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _loadingErrorWidget(
      BuildContext context, ProductModel productBlocModel) {
    return Row(
      children: [
        Flexible(
            child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'ERROR: Something went wrong while loading the product'),
              productBlocModel != null
                  ? ElevatedButton(
                      onPressed: () {
                        bloc.add(LoadProductEvent(productBlocModel));
                      },
                      child: const Text('Error Try Again'))
                  : const Text('data')
            ],
          ),
        ))
      ],
    );
  }

  Widget _productDetail(ProductModel product) {
    String rawAmount = product.price!;
    String productAmount = rawAmount.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    int number = 1;
    PageController _pageController = PageController(
      // viewportFraction: 0.8,
      initialPage: 0,
    );
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                  itemCount: product.imgsUrl!.length,
                  pageSnapping: true,
                  controller: _pageController,
                  onPageChanged: (int num) {
                    // ============= Image Index Indicator ==============

                    setState(() {
                      if (num % 2 != 0) {
                        number += 1;
                      }
                    });
                  },
                  itemBuilder: (context, imagePosition) {
                    return Stack(
                      children: [
                        Image.network(
                          product.imgsUrl![imagePosition],
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Container(
                              height: 20,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.transparent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                '${imagePosition + number}/${product.imgsUrl!.length}',
                                style: const TextStyle(
                                    color: a4_style.lavenderBlush),
                              )),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: a4_style.rctGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "₦$productAmount",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: a4_style.lavenderBlush),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      productBadge(badgeLabel: product.description!),
                      Text(product.description!),
                      const Text("Total Sales: 0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          product.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: a4_style.lavenderBlush),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Product ID: ${product.id.toString()} ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: a4_style.lavenderBlush),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: a4_style.rctGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      productBadge(badgeLabel: "Trending"),
                      // Text("Size: ${product.memorySize}"),
                      const Text("Total Sales: 0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Product ID: ${product.id.toString()} ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: a4_style.lavenderBlush),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
