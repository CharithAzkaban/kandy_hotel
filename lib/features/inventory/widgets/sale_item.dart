import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/sale_product.dart';
import 'package:kandy_hotel/providers/sale_provider.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_icon_button.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class SaleItem extends StatelessWidget {
  final SaleProduct saleProduct;
  const SaleItem(this.saleProduct, {super.key});

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
              '${price(productPrice)} × ${number(quantity)} = ${price(productPrice * quantity)}',
              align: TextAlign.left,
            );
          },
        ),
        trailing: Builder(
          builder: (context) {
            final saleProvider = provider<SaleProvider>(context);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VaaruIconButton(
                  icon: saleProduct.quantity > 1 ? Icons.remove_rounded : Icons.delete_rounded,
                  color: error,
                  onPressed: () => saleProvider.removeSaleItem(saleProduct.product.id),
                ),
                const Gap(h: 5.0),
                VaaruIconButton(
                  icon: Icons.add_rounded,
                  color: primary,
                  onPressed: () => saleProvider.addSaleItem(saleProduct.product),
                ),
              ],
            );
          },
        ),
      );
}
