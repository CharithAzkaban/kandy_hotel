import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';

class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController buyingPriceController;
  final TextEditingController sellingPriceController;
  final String? existingImageUrl;
  const ProductForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.buyingPriceController,
    required this.sellingPriceController,
    this.existingImageUrl,
  });

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VaaruTff(
              controller: nameController,
              labelText: 'Name',
              autofocus: true,
              validator: (text) =>
                  textOrEmpty(text).isEmpty ? 'Required!' : null,
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: sellingPriceController,
              labelText: 'Selling Price',
              prefixText: 'Rs. ',
              validator: (text) =>
                  textOrEmpty(text).isEmpty ? 'Required!' : null,
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: buyingPriceController,
              labelText: 'Buying Price',
              prefixText: 'Rs. ',
              validator: (text) =>
                  textOrEmpty(text).isEmpty ? 'Required!' : null,
              formatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]*$')),
              ],
            ),
          ],
        ),
      );
}
