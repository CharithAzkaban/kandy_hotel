import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/models/return_product.dart';
import 'package:kandy_hotel/services/return_services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:kandy_hotel/utils/methods.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'product_provider.dart';

class ReturnProvider extends ChangeNotifier {
  final _returnProducts = <ReturnProduct>[];

  List<ReturnProduct> get returnProducts => _returnProducts;

  void returnProduct(
    BuildContext context, {
    required Product product,
    required double quantity,
  }) =>
      waiting(
        context,
        waitingMessage: 'Returning...',
        process: () => ReturnServices.returnProduct(
          product: product,
          quantity: quantity,
        ),
        afterProcessed: (returnedProduct) {
          _returnProducts.add(returnedProduct);
          notify(title: 'Returned', body: 'A product has been returned successfully.');
          notifyListeners();
          provider<ProductProvider>(context).loadProducts(context, notify: true);
        },
      );

  void loadReturns(
    BuildContext context, {
    required int year,
    required int? month,
    required PickerDateRange? dateRange,
  }) =>
      waiting(
        context,
        waitingMessage: 'Loading returns...',
        process: () => ReturnServices.getReturnsByDate(
          year: year,
          month: month,
          startDay: dateRange?.startDate?.day,
          endDay: dateRange?.endDate?.day,
        ),
        afterProcessed: (returnedProduct) {
          _returnProducts.clear();
          _returnProducts.addAll(returnedProduct);
          notifyListeners();
        },
      );

  void disposeData() {
    _returnProducts.clear();
  }
}
