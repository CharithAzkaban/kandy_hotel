import 'package:flutter/material.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';

class ProductForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController buyingPriceController;
  final TextEditingController sellingPriceController;
  final TextEditingController avbQuantityController;
  const ProductForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.buyingPriceController,
    required this.sellingPriceController,
    required this.avbQuantityController,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _sellingPriceFocus = FocusNode();
  final _buyingPriceFocus = FocusNode();
  final _avbQuantityFocus = FocusNode();

  @override
  void dispose() {
    _sellingPriceFocus.dispose();
    _buyingPriceFocus.dispose();
    _avbQuantityFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VaaruTff(
              controller: widget.nameController,
              labelText: 'Name',
              autofocus: true,
              require: true,
              onFieldSubmitted: (_) => _sellingPriceFocus.requestFocus(),
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: widget.sellingPriceController,
              focusNode: _sellingPriceFocus,
              labelText: 'Selling Price',
              prefixText: 'Rs. ',
              require: true,
              onlyDecimals: true,
              onFieldSubmitted: (_) => _buyingPriceFocus.requestFocus(),
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: widget.buyingPriceController,
              focusNode: _buyingPriceFocus,
              labelText: 'Buying Price',
              prefixText: 'Rs. ',
              require: true,
              onlyDecimals: true,
              onFieldSubmitted: (_) => _avbQuantityFocus.requestFocus(),
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: widget.avbQuantityController,
              focusNode: _avbQuantityFocus,
              labelText: 'Available Quantity',
              require: true,
              onlyDecimals: true,
              onFieldSubmitted: (_) {
                if (widget.formKey.currentState!.validate()) {
                  pop(context, result: true);
                }
              },
            ),
          ],
        ),
      );
}
