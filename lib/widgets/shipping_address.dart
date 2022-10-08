import 'package:flutter/material.dart';

import '../shared/styles/shared_colors.dart' as a4_style;

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: a4_style.scaffoldBG,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Center(
              child: Text(
                'SHIPPING ADDRESS',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const Divider(thickness: 2),
            Text('CITY - ', style: Theme.of(context).textTheme.bodySmall),
            Text('STATE - ', style: Theme.of(context).textTheme.bodySmall),
            Text('ZIP CODE - ', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
