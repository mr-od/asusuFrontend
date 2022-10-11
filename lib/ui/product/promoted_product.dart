import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../logic/logic.dart';
import '../../shared/shared.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../ui.dart';

class PromotedProducts extends StatefulWidget {
  // final VendorRepositories vendorRepo;

  const PromotedProducts({
    Key? key,
    // required this.vendorRepo
  }) : super(key: key);

  @override
  State<PromotedProducts> createState() => _PromotedProductsState();
}

class _PromotedProductsState extends State<PromotedProducts> {
  int selectedIndex = 0;

  /////// One Way to add Blocs //////////
  // loadVendorProducts() async {
  //   context.read<VendorBloc>().add(FetchVendorProductsEvent());
  // }

  // @override
  // void initState() {
  //   loadVendorProducts();
  //   super.initState();
  // }

  /////// One Way to add Blocs //////////

//// Another way to add Bloc ///////
  ///
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(FetchPromotedProductsEvent());
    super.initState();
  }

//// Another way to add Bloc ///////

  @override
  Widget build(BuildContext context) {
    // if Stateless Widget// Use This
    // BlocProvider.of<VendorBloc>(context).add(FetchVendorProductsEvent());

    return Container(
      color: Colors.white,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: eerieBlack,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(myAppBarHeight),
            child: AppBar(
              backgroundColor: a4_style.pureBlack,
            )),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: searchFormField(
                  label: "Search", prefix: "assets/icons/A4logo.png"),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (BuildContext context, ProductState state) {
                if (state is PromotedProductLoadingState) {
                  debugPrint('Product Loading State : $state');
                  return _vendorLoading();
                } else if (state is PromotedProductLoadedState) {
                  debugPrint('Product Loaded State : $state');
                  return _vendorProducts(state.productModel);
                } else if (state is PromotedProductErrorState) {
                  debugPrint('Vendor Products Error State : $state');
                  return const Text(
                      'There was an error loading your products.');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
        // bottomNavigationBar: CustomBottomNavigationBar(
        //   iconList: icons,
        //   onChange: _onItemTapped,
        // ),
      ),
    );
  }

  static List<Widget> icons = <Widget>[
    Image.asset(
      'assets/icons/Menu.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/cart.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/A4logo.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/connect.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/profile.png',
      height: 35,
      width: 35,
    ),
  ];

  Widget _vendorProducts(List<ProductModel> productModel) {
    return Expanded(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: productModel.length,
        itemBuilder: (BuildContext context, int i) {
          return productCard(productModel[i], context);
        },
        staggeredTileBuilder: (int i) => const StaggeredTile.fit(1),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }

  InkWell productCard(ProductModel product, BuildContext context) {
    return InkWell(
      onTap: () {
        // One way to navigate
        // BlocProvider.of<ProductBloc>(context).add(LoadProductEvent(product));
        // goTo(context, const ProductDetailScreen());

        // Another way to navigate
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => BlocProvider.value(
        //               value: BlocProvider.of<ProductBloc>(context)
        //                 ..add(LoadProductEvent(product)),
        //               child: ProductDetailScreen(
        //                 product: product,
        //               ),
        //             )));

        BlocProvider.of<ProductBloc>(context).add(LoadProductEvent(product));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(
            product: product,
          );
        }));
      },
      child: Card(
        color: a4_style.smokyBlack,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                    height: 180,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: Image.network(
                      product.imgsUrl![0],
                      fit: BoxFit.cover,
                    ))
              ]),
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
                  Text(
                    "\$${product.price.toString()}",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: a4_style.amaranth, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sold: 10",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: a4_style.amaranth,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _vendorLoading() => const Center(child: CircularProgressIndicator());

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
