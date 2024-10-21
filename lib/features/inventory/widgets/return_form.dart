import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:kandy_hotel/widgets/vaaru_tff.dart';

class ReturnForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Product product;
  final TextEditingController quantityController;
  const ReturnForm({
    super.key,
    required this.formKey,
    required this.product,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VaaruText(
            product.name,
            size: 18.0,
          ),
          const Gap(v: 10.0),
          Form(
            key: formKey,
            child: VaaruTff(
              controller: quantityController,
              labelText: 'Quantity',
              autofocus: true,
              onlyDecimals: true,
              require: true,
              validator: (text) {
                final quantity = double.tryParse(textOrEmpty(text)) ?? 0.0;
                if (product.avbQuantity < quantity) {
                  return 'Quantity exceeded!';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                if (formKey.currentState!.validate()) {
                  pop(context, result: true);
                }
              },
            ),
          ),
        ],
      );
}
