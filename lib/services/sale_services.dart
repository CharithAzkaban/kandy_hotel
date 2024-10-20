import 'package:kandy_hotel/models/product.dart';
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
    final productBox = await openHiveBox<Product>(Boxes.products);
    final sale = Sale(
      id: uuid(),
      products: saleProducts,
      discount: discount ?? 0.0,
      createdAt: DateTime.now(),
    );
    await saleBox.add(sale);
    for(final saleProduct in saleProducts){
      final product = saleProduct.product;
      await productBox.put(product.key, product.changeQuantity(product.avbQuantity - saleProduct.quantity));
    }
    saleBox.close();
    productBox.close();
    return sale;
  }
}
