import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/models/sale.dart';
import 'package:kandy_hotel/utils/attributes.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:kandy_hotel/widgets/dummy.dart';
import 'package:kandy_hotel/widgets/vaaru_text.dart';

import 'sale_product_list_item.dart';

class ProductInquiryList extends StatelessWidget {
  final List<Sale> sales;
  final Product product;
  const ProductInquiryList(
    this.sales, {
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400.0,
        height: 500.0,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final sale = sales[index];
                  final saleItems = sale.products.where((element) => element.product.id == product.id).toList();
                  return saleItems.isNotEmpty
                      ? SaleProductListItem(
                          saleItems,
                          createdAt: sale.createdAt,
                        )
                      : const Dummy();
                },
                itemCount: sales.length,
              ),
            ),
            const Divider(),
            Builder(builder: (context) {
              var total = 0.0;
              var profit = 0.0;

              for (final sale in sales) {
                final saleProducts = sale.products.where((element) => element.product.id == product.id).toList();
                final subTotal = saleProducts.fold(0.0, (total, saleProduct) => total + saleProduct.quantity * saleProduct.product.sellingPrice);
                final subProfit = saleProducts.fold(0.0, (total, saleProduct) => total + saleProduct.quantity * (saleProduct.product.sellingPrice - saleProduct.product.buyingPrice));
                total += subTotal;
                profit += subProfit;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VaaruText(
                    'Profit: ${price(profit)}',
                    weight: FontWeight.bold,
                    color: success,
                    size: 15.0,
                  ),
                  VaaruText(
                    'Total: ${price(total)}',
                    weight: FontWeight.bold,
                    color: blue,
                    size: 15.0,
                  ),
                ],
              );
            }),
            const Divider(height: 5.0),
            const Divider(height: 5.0),
          ],
        ),
      );
}
