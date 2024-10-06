import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/sale.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

import 'sale_product_item.dart';

class SaleProductsList extends StatelessWidget {
  final Sale sale;
  const SaleProductsList(this.sale, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400.0,
        height: 500.0,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => SaleProductItem(sale.products[index]),
                itemCount: sale.products.length,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VaaruText(
                  'Profit: ${price(sale.netProfit)}',
                  weight: FontWeight.bold,
                  color: success,
                  size: 15.0,
                ),
                VaaruText(
                  'Total: ${price(sale.totalPrice)}',
                  weight: FontWeight.bold,
                  color: blue,
                  size: 15.0,
                ),
              ],
            ),
            const Divider(height: 5.0),
            const Divider(height: 5.0),
          ],
        ),
      );
}
