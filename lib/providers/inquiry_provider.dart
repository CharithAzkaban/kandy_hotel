import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/sale.dart';
import 'package:kandy_hotel/services/inquiry_services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class InquiryProvider extends ChangeNotifier {
  final _sales = <Sale>[];

  List<Sale> get sales => _sales;

  void loadInquirySales(
    BuildContext context, {
    required int year,
    required int? month,
    required PickerDateRange? dateRange,
  }) =>
      waiting(
        context,
        waitingMessage: 'Loading sales...',
        process: () => InquiryServices.getSalesByDate(
          year: year,
          month: month,
          startDay: dateRange?.startDate?.day,
          endDay: dateRange?.endDate?.day,
        ),
        afterProcessed: (sales) {
          _sales.clear();
          _sales.addAll(sales);
          notifyListeners();
        },
      );

  void disposeData() {
    _sales.clear();
  }
}
