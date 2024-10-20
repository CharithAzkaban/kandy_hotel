import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/inventory/widgets/product_date_range_box.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/providers/sale_provider.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/popup_action.dart';
import 'package:kandy_hotel/widgets/vaaru_icon_button.dart';
import 'package:kandy_hotel/widgets/vaaru_menu.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
            const Gap(h: 20.0),
            VaaruText(
              product.avbQuantity == 0.0 ? 'Out of Stock' : '${number(product.avbQuantity, unit: 'unit')} available',
              align: TextAlign.left,
              weight: FontWeight.bold,
              color: product.avbQuantity < 5 ? error : null,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<SaleProvider>(builder: (context, saleData, _) {
              final isAdded = saleData.saleItems.where((element) => element.product.id == product.id).isNotEmpty;
              return VaaruMenu(
                iconColor: primary,
                tooltip: product.name,
                items: [
                  VaaruMenuItem(
                    value: 1,
                    label: 'MODIFY',
                    color: primary,
                    enabled: !isAdded,
                  ),
                  VaaruMenuItem(
                    value: 2,
                    label: 'REMOVE',
                    color: error,
                    enabled: !isAdded,
                  ),
                  VaaruMenuItem(
                    value: 3,
                    label: 'INQUIRY',
                    color: blue,
                    enabled: !isAdded,
                  ),
                  VaaruMenuItem(
                    value: 4,
                    label: 'RETURN',
                    color: warn,
                    enabled: !isAdded,
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
                  if (value == 3) {
                    PickerDateRange? selectedRange;
                    popup<PickerDateRange?>(
                      context,
                      title: product.name,
                      cancelColor: blue,
                      cancelLabel: "DONE",
                      body: ProductDateRangeBox(onSelected: (range) => selectedRange = range),
                      onValue: (_) {
                        if (selectedRange != null) {
                          productProvider.showProductInquiry(
                            context,
                            dateRange: selectedRange,
                            product: product,
                          );
                        }
                        return null;
                      },
                    );
                  }
                },
              );
            }),
            VaaruIconButton(
              icon: Icons.send_rounded,
              color: primary,
              onPressed: () => provider<SaleProvider>(context).addSaleItem(product),
            ),
          ],
        ),
      );

  void _editProduct(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: product.name);
    final buyingPriceController = TextEditingController(text: number(product.buyingPrice));
    final sellingPriceController = TextEditingController(text: number(product.sellingPrice));
    final avbQuantityController = TextEditingController(text: number(product.avbQuantity));
    popup<bool>(
      context,
      title: 'Modify Product',
      cancelLabel: 'DISMISS',
      body: ProductForm(
        formKey: formKey,
        nameController: nameController,
        buyingPriceController: buyingPriceController,
        sellingPriceController: sellingPriceController,
        avbQuantityController: avbQuantityController,
      ),
      actions: [
        PopupAction(
          label: 'MODIFY',
          validationKey: formKey,
          popResult: true,
        ),
      ],
      onValue: (isOk) {
        if (isOk != null && isOk && context.mounted) {
          provider<ProductProvider>(context).editProduct(
            context,
            key: product.key,
            id: product.id,
            name: nameController.text.trim(),
            buyingPrice: double.parse(buyingPriceController.text.trim()),
            sellingPrice: double.parse(sellingPriceController.text.trim()),
            avbQuantity: double.parse(avbQuantityController.text.trim()),
          );
        }
        return null;
      },
    );
  }
}
