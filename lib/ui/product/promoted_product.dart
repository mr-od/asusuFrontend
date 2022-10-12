import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../logic/logic.dart';
import '../../shared/shared.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../search/search_screen.dart';
import '../ui.dart';

class PromotedProducts extends StatefulWidget {
  // final VendorRepositories vendorRepo;

  PromotedProducts({
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
            preferredSize: const Size.fromHeight(50),
            child: SafeArea(
              child: AppBar(
                flexibleSpace: searchFormField(
                    onTap: () {
                      showSearch(
                          context: context,
                          delegate: SearchProducts(
                              hintText: 'Search Products',
                              sBloc: BlocProvider.of<SearchBloc>(context)));
                    },
                    label: "Search",
                    prefix: "assets/icons/A4logo.png"),
                backgroundColor: a4_style.pureBlack,
              ),
            )),
        body: Column(
          children: [
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
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, index) => productCard(productModel[index], _),
        itemCount: productModel.length,
      ),
    );
  }

  InkWell productCard(ProductModel product, BuildContext _) {
    return InkWell(
      onTap: () {
        // BlocProvider.of<ProductBloc>(_).add(LoadProductEvent(product));
        context.read<ProductBloc>().add(LoadProductEvent(product));

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

  Widget _vendorLoading() => const Center(child: CircularProgressIndicator());

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
