import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/popup_action.dart';
import 'package:kandy_hotel/widgets/vaaru_menu.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

import 'product_form.dart';

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
              label: 'MODIFY',
              color: primary,
            ),
            VaaruMenuItem(
              value: 2,
              label: 'REMOVE',
              color: error,
            ),
          ],
          onSelected: (value) {
            final productProvider = provider<ProductProvider>(context);
            if (value == 1) {
              _editProduct(context);
            }
            if (value == 2) {
              productProvider.removeProduct(
                context,
                product: product,
              );
            }
          },
        ),
      );

  void _editProduct(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: product.name);
    final buyingPriceController = TextEditingController(text: number(product.buyingPrice));
    final sellingPriceController = TextEditingController(text: number(product.sellingPrice));
    final isOk = await popup<bool>(
      context,
      title: 'Modify Product',
      cancelLabel: 'DISMISS',
      body: ProductForm(
        formKey: formKey,
        nameController: nameController,
        buyingPriceController: buyingPriceController,
        sellingPriceController: sellingPriceController,
      ),
      actions: [
        PopupAction(
          label: 'MODIFY',
          validationKey: formKey,
          popResult: true,
        ),
      ],
    );

    if (isOk != null && isOk && context.mounted) {
      provider<ProductProvider>(context).editProduct(
        context,
        key: product.key,
        id: product.id,
        name: nameController.text.trim(),
        buyingPrice: double.parse(buyingPriceController.text.trim()),
        sellingPrice: double.parse(sellingPriceController.text.trim()),
      );
    }
  }
}
