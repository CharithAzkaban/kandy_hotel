import 'package:kandy_hotel/models/sale.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';

class InquiryServices {
  static Future<List<Sale>> getSalesByDate({
    required int year,
    required int? month,
    required int? startDay,
    required int? endDay,
  }) async {
    final saleBox = await openHiveBox<Sale>(Boxes.sales);
    late final List<Sale> sales;
    final bothDaysOk = startDay != null && endDay != null;
    if (month == null) {
      sales = saleBox.values.where((element) => element.createdAt.year == year).toList();
    } else if (startDay != null && endDay == null || (bothDaysOk && startDay == endDay)) {
      sales = saleBox.values.where((element) => areSameDates(element.createdAt, DateTime(year, month, startDay))).toList();
    } else if (bothDaysOk && startDay != endDay) {
      sales = saleBox.values.where((element) {
        final createdAt = element.createdAt;
        final createdDay = createdAt.day;
        return year == createdAt.year && month == createdAt.month && createdDay >= startDay && createdDay <= endDay;
      }).toList();
    } else {
      sales = [];
    }
    return sales;
  }
}
