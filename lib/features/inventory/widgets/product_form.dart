import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';

class ProductForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController buyingPriceController;
  final TextEditingController sellingPriceController;
  final String? existingImageUrl;
  final GlobalKey<SliverAnimatedListState>? listKey;
  const ProductForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.buyingPriceController,
    required this.sellingPriceController,
    this.existingImageUrl,
    this.listKey,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _sellingPriceFocus = FocusNode();
  final _buyingPriceFocus = FocusNode();

  @override
  void dispose() {
    _sellingPriceFocus.dispose();
    _buyingPriceFocus.dispose();
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
              validator: (text) => textOrEmpty(text).isEmpty ? 'Required!' : null,
              onFieldSubmitted: (_) => _sellingPriceFocus.requestFocus(),
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: widget.sellingPriceController,
              focusNode: _sellingPriceFocus,
              labelText: 'Selling Price',
              prefixText: 'Rs. ',
              formatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]*$'))],
              validator: (text) => textOrEmpty(text).isEmpty ? 'Required!' : null,
              onFieldSubmitted: (_) => _buyingPriceFocus.requestFocus(),
            ),
            const Gap(v: 15.0),
            VaaruTff(
              controller: widget.buyingPriceController,
              focusNode: _buyingPriceFocus,
              labelText: 'Buying Price',
              prefixText: 'Rs. ',
              formatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]*$'))],
              validator: (text) => textOrEmpty(text).isEmpty ? 'Required!' : null,
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
