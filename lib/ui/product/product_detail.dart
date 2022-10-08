import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';
import '../../shared/shared.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../ui.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState(product);
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  final ProductModel productM;

  bool _addedToCart = false;
  _ProductDetailScreenState(this.productM);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: a4_style.scaffoldMBG,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(myAppBarHeight),
              child: AppBar(
                backgroundColor: a4_style.defaultColor,
              )),
          body: BlocBuilder<ProductBloc, ProductState>(
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
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: defaultButton(
                      function: () {},
                      text: 'Edit Product',
                      buttonColor: a4_style.defaultColor)),
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is CartLoaded) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_addedToCart == false) {
                            // BlocProvider.of<CartBloc>(context)
                            //     .add(AddProduct(product));
                            context.read<CartBloc>().add(AddProduct(productM));
                            // debugPrint(productM.brand);
                            goTo(context, CartScreen());
                            setState(() {
                              _addedToCart = true;
                            });
                          } else {
                            goTo(context, CartScreen());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: a4_style.buttonBG,
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: Text(
                          _addedToCart ? 'View Cart' : 'Add To Cart',
                          style: Theme.of(context).textTheme.button,
                        ),
                      );
                    }
                    return const Text('Something went wrong!');
                  },
                ),
              ),
            ],
          ),
        ),
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
                  'ERROR: Something went wrong during the loading of the product'),
              productBlocModel != null
                  ? ElevatedButton(
                      onPressed: () {
                        final productBloc =
                            BlocProvider.of<ProductBloc>(context);
                        productBloc.add(LoadProductEvent(productBlocModel));
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
    double rawAmount = product.price!;
    String productAmount = rawAmount.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    int number = 1;
    PageController _pageController = PageController(
      // viewportFraction: 0.8,
      initialPage: 0,
    );
    return Column(
      children: [
        searchContainer(
          onPop: () {
            goPop(context);
          },
          onTap: () {
            // showSearch(
            //     context: context,
            //     delegate: SearchProducts(
            //         hintText: 'Search Your Products',
            //         searchVendorProducts: BlocProvider.of<SearchBloc>(context))
            //     // ProductSearch(
            //     //     searchBloc:
            //     //         BlocProvider.of<SearchBloc>(context))
            //     );
          },
          onPressed: () {
            // showSearch(
            //   context: context,
            //   delegate: SearchProducts(
            //       hintText: 'Search Your Products',
            //       searchVendorProducts: BlocProvider.of<SearchBloc>(context)),
            //   // ProductSearch(
            //   //     searchBloc:
            //   //         BlocProvider.of<SearchBloc>(context))
            // );
          },
        ),
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
                                style: const TextStyle(color: Colors.white),
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
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: a4_style.navPane,
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
                          .copyWith(color: a4_style.defaultColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: a4_style.defaultColor,
                        child: const Text('Logo'),
                      ),
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
                              .copyWith(color: a4_style.defaultColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Product ID: ${product.id.toString()} ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: a4_style.defaultColor),
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
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: a4_style.navPane,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Brand:${product.brand}",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: a4_style.appGrey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: a4_style.defaultColor,
                        child: const Text('Trending'),
                      ),
                      Text("Size: ${product.memorySize}"),
                      const Text("Total Sales: 0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Condition:      ${product.condition}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: a4_style.appGrey),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Product ID: ${product.id.toString()} ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: a4_style.defaultColor),
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















// class ProductDetailScreen extends StatefulWidget {
//   // final ProductModel productM;

//   const ProductDetailScreen({
//     Key? key,
//     // required this.productM,
//   }) : super(key: key);

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen>
//     with TickerProviderStateMixin {
//   // final ProductModel productM;
//   _ProductDetailScreenState();
//   bool _addedToCart = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: PreferredSize(
//               preferredSize: Size.fromHeight(myAppBarHeight),
//               child: AppBar(
//                 backgroundColor: a4_style.defaultColor,
//               )),
//           body: BlocBuilder<ProductBloc, ProductState>(
//               builder: (BuildContext context, ProductState state) {
//             if (state is ProductLoadingState) {
//               return _vendorLoading();
//             } else if (state is ProductErrorState) {
//               return _loadingErrorWidget(context, state.productBlocModel);
//             } else if (state is ProductLoadedState) {
//               return _productDetail(state.productBlocModel);
//             } else {
//               return Center(child: Text('The state is : $state'));
//             }
//           }),
//           // bottomNavigationBar: Container(
//           //   margin: const EdgeInsets.only(left: 50, right: 50, top: 50),
//           //   height: 70,
//           //   decoration: const BoxDecoration(
//           //       color: a4_style.navPane,
//           //       borderRadius: BorderRadius.only(
//           //           topLeft: Radius.circular(10),
//           //           topRight: Radius.circular(10))),
//           //   child: Wrap(
//           //     alignment: WrapAlignment.spaceAround,
//           //     children: [
//           //       iconBox(
//           //           imgPath: 'assets/images/afia4Logo.png',
//           //           iconTitle: 'Home',
//           //           iconFunction: () {
//           //             goTo(context, const MainHomeScreen());
//           //           }),
//           //       iconBox(
//           //           imgPath: 'assets/images/user.png',
//           //           iconTitle: 'Profile',
//           //           iconFunction: () {
//           //             goTo(context, const ProfileScreen());
//           //           })
//           //     ],
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }

//   Widget _vendorLoading() => const Center(child: CircularProgressIndicator());

//   Widget _loadingErrorWidget(
//       BuildContext context, ProductModel productBlocModel) {
//     return Row(
//       children: [
//         Flexible(
//             child: Container(
//           padding: const EdgeInsets.all(50),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                   'ERROR: Something went wrong during the loading of the product'),
//               productBlocModel != null
//                   ? ElevatedButton(
//                       onPressed: () {
//                         final productBloc =
//                             BlocProvider.of<ProductBloc>(context);
//                         productBloc.add(LoadProductEvent(productBlocModel));
//                       },
//                       child: const Text('Error Try Again'))
//                   : const Text('data')
//             ],
//           ),
//         ))
//       ],
//     );
//   }

//   Widget _productDetail(ProductModel product) {
//     int number = 1;
//     PageController _pageController = PageController(
//       // viewportFraction: 0.8,
//       initialPage: 0,
//     );
//     return Column(
//       children: [
//         searchContainer(
//           onPop: () {
//             goPop(context);
//           },
//           onTap: () {
//             // showSearch(
//             //     context: context,
//             //     delegate: SearchProducts(
//             //         hintText: 'Search Your Products',
//             //         searchVendorProducts: BlocProvider.of<SearchBloc>(context))
//             //     // ProductSearch(
//             //     //     searchBloc:
//             //     //         BlocProvider.of<SearchBloc>(context))
//             //     );
//           },
//           onPressed: () {
//             // showSearch(
//             //   context: context,
//             //   delegate: SearchProducts(
//             //       hintText: 'Search Your Products',
//             //       searchVendorProducts: BlocProvider.of<SearchBloc>(context)),
//             //   // ProductSearch(
//             //   //     searchBloc:
//             //   //         BlocProvider.of<SearchBloc>(context))
//             // );
//           },
//         ),
//         Stack(
//           alignment: AlignmentDirectional.bottomStart,
//           children: [
//             SizedBox(
//               height: 300,
//               width: MediaQuery.of(context).size.width,
//               child: PageView.builder(
//                   itemCount: product.imgsUrl!.length,
//                   pageSnapping: true,
//                   controller: _pageController,
//                   onPageChanged: (int num) {
//                     // ============= Image Index Indicator ==============

//                     setState(() {
//                       if (num % 2 != 0) {
//                         number += 1;
//                       }
//                     });
//                   },
//                   itemBuilder: (context, imagePosition) {
//                     return Stack(
//                       children: [
//                         Image.network(
//                           product.imgsUrl![imagePosition],
//                           height: 400,
//                           width: MediaQuery.of(context).size.width,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Align(
//                             alignment: AlignmentDirectional.bottomEnd,
//                             child: Container(
//                               height: 20,
//                               width: 30,
//                               decoration: BoxDecoration(
//                                   color: Colors.transparent.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                   child: Text(
//                                 '${imagePosition + number}/${product.imgsUrl!.length}',
//                                 style: const TextStyle(color: Colors.white),
//                               )),
//                             ),
//                           ),
//                         )
//                       ],
//                     );
//                   }),
//             ),
//           ],
//         ),
//         Text(product.name!),
//         Text(product.description!),
//         Text(product.id.toString()),
//         Text(
//           "₦${product.price}",
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         const Spacer(),
//         ElevatedButton(
//             onPressed: () {
//               goTo(context, CartScreen());
//             },
//             child: const Text('View Cart')),
//         Expanded(
//           child: BlocBuilder<CartBloc, CartState>(
//             builder: (context, state) {
//               if (state is CartLoading) {
//                 return const CircularProgressIndicator();
//               }
//               if (state is CartLoaded) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     if (_addedToCart == false) {
//                       // BlocProvider.of<CartBloc>(context)
//                       //     .add(AddProduct(product));
//                       context.read<CartBloc>().add(AddProduct(product));
//                       goTo(context, CartScreen());
//                       setState(() {
//                         _addedToCart = true;
//                       });
//                     } else {
//                       goTo(context, CartScreen());
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: a4_style.buttonBG,
//                     shape: const RoundedRectangleBorder(),
//                   ),
//                   child: Text(
//                     _addedToCart ? 'View Cart' : 'Add To Cart',
//                     style: Theme.of(context).textTheme.button,
//                   ),
//                 );
//               }
//               return const Text('Something went wrong!');
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
