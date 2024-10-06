import 'package:hive/hive.dart';
import 'package:kandy_hotel/models/sale_product.dart';

part 'sale.g.dart';

@HiveType(typeId: 2)
class Sale extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<SaleProduct> products;

  @HiveField(2)
  double discount;

  @HiveField(3)
  final DateTime createdAt;

  Sale({
    required this.id,
    required this.products,
    required this.discount,
    required this.createdAt,
  });

  double get netProfit => products.fold(0.0, (profit, saleProduct) {
        final product = saleProduct.product;
        final productProfit = product.sellingPrice - product.buyingPrice;
        return profit + productProfit * saleProduct.quantity;
      });

  double get totalPrice => products.fold(0.0, (total, product) => total + (product.quantity * product.product.sellingPrice));
}
