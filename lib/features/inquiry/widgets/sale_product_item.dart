import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/sale_product.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class SaleProductItem extends StatelessWidget {
  final SaleProduct saleProduct;
  const SaleProductItem(this.saleProduct, {super.key});

  @override
  Widget build(BuildContext context) => ListTile(
        title: VaaruText(
          saleProduct.product.name,
          size: 20.0,
          align: TextAlign.left,
        ),
        subtitle: Builder(
          builder: (context) {
            final product = saleProduct.product;
            final productPrice = product.sellingPrice;
            final quantity = saleProduct.quantity;
            return VaaruText(
              '${price(productPrice)} × ${number(quantity)}',
              align: TextAlign.left,
            );
          },
        ),
        trailing: Builder(builder: (context) {
          final product = saleProduct.product;
          final sellingPrice = product.sellingPrice;
          final buyingPrice = product.buyingPrice;
          final quantity = saleProduct.quantity;
          final total = sellingPrice * quantity;
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
                price(total - buyingPrice * quantity),
                align: TextAlign.left,
                color: success,
                weight: FontWeight.bold,
              ),
            ],
          );
        }),
      );
}
