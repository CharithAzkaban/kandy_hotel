import 'package:flutter/material.dart';
import 'package:kandy_hotel/features/inquiry/widgets/sale_products_list.dart';
import 'package:kandy_hotel/models/sale.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/gap.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';
import 'package:kandy_hotel/widgets/vaaru_text_button.dart';

class InquirySaleItem extends StatelessWidget {
  final Sale sale;
  const InquirySaleItem(this.sale, {super.key});

  @override
  Widget build(BuildContext context) => ListTile(
        title: VaaruText(
          date(sale.createdAt),
          size: 20.0,
          align: TextAlign.left,
        ),
        subtitle: Row(
          children: [
            VaaruText(
              'Sale: ${price(sale.totalPrice)}',
              align: TextAlign.left,
              color: blue,
              weight: FontWeight.bold,
            ),
            const Gap(h: 20.0),
            VaaruText(
              'Profit: ${price(sale.netProfit)}',
              align: TextAlign.left,
              color: success,
              weight: FontWeight.bold,
            ),
          ],
        ),
        trailing: VaaruTextButton(
          label: number(sale.products.length, unit: 'item'),
          icon: Icons.list_alt_rounded,
          leftIcon: false,
          onPressed: () => popup(
            context,
            title: 'Sale on ${date(sale.createdAt)}',
            body: SaleProductsList(sale),
          ),
        ),
      );
}
