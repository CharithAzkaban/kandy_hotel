import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/inventory/widgets/product_form.dart';
import 'package:kandy_hotel/utils/actions.dart';

class ProductProvider extends ChangeNotifier {
  void addProduct(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final buyingPriceController = TextEditingController();
    final sellingPriceController = TextEditingController();
    popup(
      context,
      title: 'Add Product',
      cancelLabel: 'DISMISS',
      body: ProductForm(
        formKey: formKey,
        nameController: nameController,
        buyingPriceController: buyingPriceController,
        sellingPriceController: sellingPriceController,
      ),
      actions: [
        PopupAction(
          label: 'ADD',
          onPressed: (){},
        ),
      ],
    );
  }
}
