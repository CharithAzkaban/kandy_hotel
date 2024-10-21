import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/models/return_product.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';

class ReturnServices {
  static Future<ReturnProduct> returnProduct({
    required Product product,
    required double quantity,
  }) async {
    final returnBox = await openHiveBox<ReturnProduct>(Boxes.returns);
    final productBox = await openHiveBox<Product>(Boxes.products);
    final returnedProduct = ReturnProduct(
      id: uuid(),
      product: product,
      quantity: quantity,
      createdAt: DateTime.now(),
    );
    await returnBox.add(returnedProduct);
    await productBox.put(product.key, product.changeQuantity(product.avbQuantity - quantity));
    returnBox.close();
    productBox.close();
    return returnedProduct;
  }

  static Future<List<ReturnProduct>> getReturnsByDate({
    required int year,
    required int? month,
    required int? startDay,
    required int? endDay,
  }) async {
    final returnBox = await openHiveBox<ReturnProduct>(Boxes.returns);
    late final List<ReturnProduct> returns;
    final bothDaysOk = startDay != null && endDay != null;
    if (month == null) {
      returns = returnBox.values.where((element) => element.createdAt.year == year).toList();
    } else if (startDay != null && endDay == null || (bothDaysOk && startDay == endDay)) {
      returns = returnBox.values.where((element) => areSameDates(element.createdAt, DateTime(year, month, startDay))).toList();
    } else if (bothDaysOk && startDay != endDay) {
      returns = returnBox.values.where((element) {
        final createdAt = element.createdAt;
        final createdDay = createdAt.day;
        return year == createdAt.year && month == createdAt.month && createdDay >= startDay && createdDay <= endDay;
      }).toList();
    } else {
      returns = [];
    }
    return returns;
  }
}
