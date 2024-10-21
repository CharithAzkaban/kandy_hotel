import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/return_product.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class ReturnItem extends StatelessWidget {
  final ReturnProduct returnedProduct;
  const ReturnItem(this.returnedProduct, {super.key});

  @override
  Widget build(BuildContext context) => ListTile(
        title: VaaruText(
          returnedProduct.product.name,
          size: 20.0,
          align: TextAlign.left,
        ),
        subtitle: VaaruText(
          date(returnedProduct.createdAt, format: 'dd MMM yyyy, hh:mm a'),
          align: TextAlign.left,
          weight: FontWeight.bold,
        ),
        trailing: VaaruText(
          '${number(returnedProduct.quantity, unit: 'unit')} returned.',
          size: 18.0,
          weight: FontWeight.bold,
        ),
      );
}
