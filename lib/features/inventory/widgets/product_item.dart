import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_menu.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) => ListTile(
    title: VaaruText(
      product.name,
      size: 20.0,
      align: TextAlign.left,
    ),
    subtitle: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: blue),
          ),
          child: Row(
            children: [
              const Icon(Icons.arrow_downward_rounded),
              VaaruText(
                'Buy @ ${price(product.buyingPrice)}',
                align: TextAlign.left,
              ),
            ],
          ),
        ),
        const Gap(h: 20.0),
        Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: success),
          ),
          child: Row(
            children: [
              const Icon(Icons.arrow_upward_rounded),
              VaaruText(
                'Sell @ ${price(product.sellingPrice)}',
                align: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    ),
    trailing: VaaruMenu(
      tooltip: product.name,
      items: [
        VaaruMenuItem(
          value: 1,
          label: 'Edit',
          color: primary,
        ),
        VaaruMenuItem(
          value: 2,
          label: 'Remove',
          color: error,
        ),
      ],
      onSelected: (value) {
        final productProvider = provider<ProductProvider>(context);
        if (value == 2) {
          productProvider.removeProduct(
            context,
            product: product,
          );
        }
      },
    ),
  );
}
