import 'package:kandy_hotel/models/sale.dart';
import 'package:kandy_hotel/models/sale_product.dart';
import 'package:kandy_hotel/utils/enums.dart';
import 'package:kandy_hotel/utils/methods.dart';

class SaleServices {
  static Future<Sale> makeSale({
    required List<SaleProduct> saleProducts,
    required double? discount,
  }) async {
    final saleBox = await openHiveBox<Sale>(Boxes.sales);
    final sale = Sale(
      id: uuid(),
      products: saleProducts,
      discount: discount ?? 0.0,
      createdAt: DateTime.now(),
    );
    await saleBox.add(sale);
    saleBox.close();
    return sale;
  }
}
