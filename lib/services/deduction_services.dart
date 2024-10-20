import 'package:kandy_hotel/models/deduction.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';

class DeductionServices {
  static Future<Deduction> addDeduction({
    required String title,
    required double amount,
  }) async {
    final deductionBox = await openHiveBox<Deduction>(Boxes.deductions);
    final deduction = Deduction(
      id: uuid(),
      title: title,
      amount: amount,
      createdAt: DateTime.now(),
    );
    await deductionBox.add(deduction);
    deductionBox.close();
    return deduction;
  }

  static Future<List<Deduction>> getDeductionsByDate({
    required int year,
    required int? month,
    required int? startDay,
    required int? endDay,
  }) async {
    final deductionBox = await openHiveBox<Deduction>(Boxes.deductions);
    late final List<Deduction> deductions;
    final bothDaysOk = startDay != null && endDay != null;
    if (month == null) {
      deductions = deductionBox.values.where((element) => element.createdAt.year == year).toList();
    } else if (startDay != null && endDay == null || (bothDaysOk && startDay == endDay)) {
      deductions = deductionBox.values.where((element) => areSameDates(element.createdAt, DateTime(year, month, startDay))).toList();
    } else if (bothDaysOk && startDay != endDay) {
      deductions = deductionBox.values.where((element) {
        final createdAt = element.createdAt;
        final createdDay = createdAt.day;
        return year == createdAt.year && month == createdAt.month && createdDay >= startDay && createdDay <= endDay;
      }).toList();
    } else {
      deductions = [];
    }
    return deductions;
  }
}