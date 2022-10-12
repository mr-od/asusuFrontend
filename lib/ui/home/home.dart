import 'package:asusu_igbo_f/shared/components/shared_components.dart';
import 'package:asusu_igbo_f/shared/styles/shared_colors.dart';
import 'package:asusu_igbo_f/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<ProductModel> productModel = List<ProductModel>;
  late ProductBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ProductBloc>(context);
    bloc.add(FetchPromotedProductsEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'http://afia4.oss-cn-beijing.aliyuncs.com/sliders/1.jpg',
      'http://afia4.oss-cn-beijing.aliyuncs.com/sliders/2.jpg',
    ];
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        pinned: true,
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
      ),
      SliverToBoxAdapter(
          child: CarouselSlider(
        options: CarouselOptions(),
        items: imgList
            .map((item) => Center(
                child: Image.network(item, fit: BoxFit.cover, width: 1000)))
            .toList(),
      )),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/promoted");
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SelectCard(choice: choices[index]),
              ),
            );
          },
          childCount: choices.length,
        ),
      ),
      const SliverPadding(
        padding: EdgeInsets.only(bottom: 80.0),
      ),
      BlocBuilder<ProductBloc, ProductState>(
          bloc: BlocProvider.of<ProductBloc>(context),
          builder: (context, state) {
            if (state is PromotedProductLoadedState) {
              debugPrint('Product Loaded State : $state');
              // return _promotedProducts(state.productModel);
              if (state.productModel.isEmpty) {
                return const Center(
                  child: Text('No Products Yet'),
                );
              }
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  delegate:
                      SliverChildBuilderDelegate((BuildContext _, int index) {
                    // return productCard(state.productModel[index], _);

                    return InkWell(
                      onTap: () {
                        bloc.add(LoadProductEvent(state.productModel[index]));
                        Navigator.of(context).pushNamed("/productDetail");
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
                                    state.productModel[index].imgsUrl![0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                state.productModel[index].name!,
                                style: const TextStyle(color: lavenderBlush),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "\$${state.productModel[index].price.toString()}",
                                      style: Theme.of(_)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              color: amaranth,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Sold: 10",
                                      style: Theme.of(_)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              color: amaranth,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }, childCount: state.productModel.length));
            } else {
              return SliverToBoxAdapter(child: Container());
            }
          })
    ]);
  }

  Widget _promotedProducts(List<ProductModel> productModel) {
    return SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        delegate: SliverChildBuilderDelegate((BuildContext _, int index) {
          return productCard(productModel[index], _);
        }, childCount: productModel.length));
  }

  InkWell productCard(ProductModel product, BuildContext _) {
    return InkWell(
      onTap: () {
        bloc.add(LoadProductEvent(product));
        context.read<CartBloc>().add(AddProduct(product));
        Navigator.of(context).pushNamed("/productDetail");
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
}

class Choice {
  const Choice({
    required this.title,
    required this.icon,
    // this.context,
  });
  final String title;
  final Widget icon;
}

List<Choice> choices = <Choice>[
  Choice(
      title: 'New Word',
      icon: Image.asset(
        "assets/icons/insert_w.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Verify Word',
      icon: Image.asset(
        "assets/icons/verify_w.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Market',
      icon: Image.asset(
        "assets/icons/afia.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Festival',
      icon: Image.asset(
        "assets/icons/fireworks.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'History',
      icon: Image.asset(
        "assets/icons/history.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Food',
      icon: Image.asset(
        "assets/icons/nri.png",
        height: 50,
        width: 50,
      )),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: lavenderBlush, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        color: pureBlack,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: choice.icon),
                  Text(choice.title,
                      style: const TextStyle(color: lavenderBlush)),
                ]),
          ),
        ));
  }
}
