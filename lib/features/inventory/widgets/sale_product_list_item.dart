import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/sale_product.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class SaleProductListItem extends StatelessWidget {
  final List<SaleProduct> saleProducts;
  final DateTime createdAt;
  const SaleProductListItem(
    this.saleProducts, {
    super.key,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        title: VaaruText(
          date(createdAt, format: 'dd MMM yyyy, hh:mm a'),
          size: 20.0,
          align: TextAlign.left,
        ),
        subtitle: Builder(
          builder: (context) {
            final quantity = saleProducts.fold(0.0, (total, saleProduct) => total + saleProduct.quantity);
            return VaaruText(
              number(quantity, unit: 'unit'),
              align: TextAlign.left,
            );
          },
        ),
        trailing: Builder(builder: (context) {
          final total = saleProducts.fold(0.0, (total, saleProduct) => total + saleProduct.quantity * saleProduct.product.sellingPrice);
          final profit = saleProducts.fold(0.0, (total, saleProduct) => total + saleProduct.quantity * (saleProduct.product.sellingPrice - saleProduct.product.buyingPrice));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              VaaruText(
                price(total),
                align: TextAlign.left,
                color: blue,
                weight: FontWeight.bold,
              ),
              VaaruText(
                price(profit),
                align: TextAlign.left,
                color: success,
                weight: FontWeight.bold,
              ),
            ],
          );
        }),
      );
}
