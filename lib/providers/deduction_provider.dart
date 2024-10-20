import 'package:flutter/material.dart';
import 'package:kandy_hotel/models/deduction.dart';
import 'package:kandy_hotel/services/deduction_services.dart';
import 'package:kandy_hotel/utils/actions.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DeductionProvider extends ChangeNotifier {
  final _deductions = <Deduction>[];

  List<Deduction> get deductions => _deductions;

  void addDeduction(
    BuildContext context, {
    required String title,
    required double amount,
  }) =>
      waiting(
        context,
        waitingMessage: 'Adding...',
        process: () => DeductionServices.addDeduction(
          title: title,
          amount: amount,
        ),
        afterProcessed: (deduction) {
          _deductions.add(deduction);
          notify(title: 'Added', body: 'A new deduction has been added successfully.');
          notifyListeners();
        },
      );

  void loadDeductions(
    BuildContext context, {
    required int year,
    required int? month,
    required PickerDateRange? dateRange,
  }) =>
      waiting(
        context,
        waitingMessage: 'Loading deductions...',
        process: () => DeductionServices.getDeductionsByDate(
          year: year,
          month: month,
          startDay: dateRange?.startDate?.day,
          endDay: dateRange?.endDate?.day,
        ),
        afterProcessed: (deductions) {
          _deductions.clear();
          _deductions.addAll(deductions);
          notifyListeners();
        },
      );

  void disposeData() {
    _deductions.clear();
  }
}
