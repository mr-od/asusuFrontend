import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/cart/cart_bloc.dart';
import '../../shared/components/shared_components.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../../widgets/order_summary.dart';
import '../../widgets/product_card.dart';
import '../checkout/checkout.dart';
import '../home/landing.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            backgroundColor: a4_style.buttonBG,
          )),
      bottomNavigationBar: const GoToCheckoutNavBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is CartLoaded) {
            Map cart = state.cart.productQuantity(state.cart.products);

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.cart.freeDeliveryString,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w200),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          goTo(context, const LandingPage());
                          // Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: a4_style.buttonBG,
                          shape: const RoundedRectangleBorder(),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add More Items',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  // const Expanded(child: SizedBox(height: 20)),
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: cart.keys.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard.cart(
                            product: cart.keys.elementAt(index),
                            quantity: cart.values.elementAt(index),
                          );
                        },
                      ),
                    ),
                  ),
                  const OrderSummary(),
                ],
              ),
            );
          }
          return const Text('Something went wrong');
        },
      ),
    );
  }
}

class GoToCheckoutNavBar extends StatelessWidget {
  const GoToCheckoutNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              goTo(context, CheckoutScreen());
            },
            style: ElevatedButton.styleFrom(
              primary: a4_style.buttonBG,
              shape: const RoundedRectangleBorder(),
            ),
            child: Text(
              'GO TO CHECKOUT',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
