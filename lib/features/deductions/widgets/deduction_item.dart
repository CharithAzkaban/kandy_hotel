import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/deduction.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

class DeductionItem extends StatelessWidget {
  final Deduction deduction;
  const DeductionItem(this.deduction, {super.key});

  @override
  Widget build(BuildContext context) => ListTile(
        title: VaaruText(
          deduction.title,
          size: 20.0,
          align: TextAlign.left,
        ),
        subtitle: VaaruText(
          date(deduction.createdAt, format: 'dd MMM yyyy, hh:mm a'),
          align: TextAlign.left,
          weight: FontWeight.bold,
        ),
        trailing: VaaruText(
          price(deduction.amount),
          size: 18.0,
          weight: FontWeight.bold,
        ),
      );
}
