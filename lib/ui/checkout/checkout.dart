import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:collection/collection.dart";

import '../../logic/logic.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../../widgets/widg.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final List<ProductQuantity>? productQuantity = [];
    var _orderProductQuantity = <ProductQuantity>[];
    var idInOrder;
    var quantityInOrder;

    final OrderDetails? orderDetails;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: a4_style.buttonBG,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShippingAddress(),
            const SizedBox(height: 20),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  Map aos = state.cart.productQuantity(state.cart.products);
                  var pioo = aos.keys;
                  var pio = aos.keys.toList();
                  var qio = aos.values.toList();
                  var newList = <dynamic>{...pio, ...qio}.toList();

                  // debugPrint(pio.toString());
                  // debugPrint(qio.toString());
                  // debugPrint(newList.toString());

                  String productInstance = json.encode(pio);
                  // debugPrint('Products in Cart $productInstance');
                  var group = pio
                      .groupListsBy((element) => element.id)
                      .map((key, value) => MapEntry(key, value.length));
                  // debugPrint(group.keys.toString());
                  // debugPrint('ProductsID ${group.keys}');
                  // debugPrint('Quantity $qio');
                  Map<String, dynamic> toMap() => {
                        "product_id": group.keys,
                        "quantity": qio,
                      };
                  debugPrint(toMap().toString());

                  return Expanded(
                    child: SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: aos.keys.length,
                        itemBuilder: (BuildContext context, int index) {
                          final pIndex = aos.keys.elementAt(index);
                          final qIndex = aos.values.elementAt(index);
                          return ProductCard.summary(
                            product: pIndex,
                            quantity: qIndex,
                          );
                        },
                      ),
                    ),
                  );
                }
                return const Text('Something went wrong');
              },
            ),
            const OrderSummary(),
            Container(
              height: 60,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(color: a4_style.buttonBG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          return TextButton(
                            onPressed: () async {
                              var alc = state.cart
                                  .productQuantity(state.cart.products);
                              debugPrint('ALC = ${alc.toString()}');
                              var qt = alc.values.toList();
                              var subt = state.cart.subtotalString;
                              var df = state.cart.deliveryFeeString;
                              var total = state.cart.totalString;
                              var group = state.cart.products
                                  .groupListsBy((element) => element.id)
                                  .map((key, value) =>
                                      MapEntry(key, value.length));
                              debugPrint('Group: $group');

                              String productInstance =
                                  json.encode(_orderProductQuantity);
                              debugPrint('productQuantity:$productInstance}');
                              BlocProvider.of<CartBloc>(context).add(
                                  PlaceOrderButtonPressed(
                                      productQuantity: productQuantity,
                                      subtotal: double.parse(subt),
                                      deliveryFee: double.parse(df),
                                      total: double.parse(total)));
                            },
                            child: Text(
                              'Place Order',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
                            ),
                          );
                        }
                        return const Text('There was an error');
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
