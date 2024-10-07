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

  static Future<List<Sale>> getSalesByDateRange({
    required DateTime? start,
    required DateTime? end,
  }) async {
    final saleBox = await openHiveBox<Sale>(Boxes.sales);
    final allSales = saleBox.values;
    final sales = <Sale>[];
    final dates = _getDates(start, end);
    for (final initDate in dates) {
      sales.addAll(allSales.where((element) => areSameDates(element.createdAt, initDate)));
    }
    return sales;
  }

  static List<DateTime> _getDates(DateTime? startDate, DateTime? endDate) {
    List<DateTime> dateTimes = [];
    if (startDate != null && endDate != null) {
      for (DateTime date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(const Duration(days: 1))) {
        dateTimes.add(date);
      }
    }
    return dateTimes;
  }
}
