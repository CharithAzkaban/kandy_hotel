import 'package:hive/hive.dart';
import 'package:kandy_hotel/models/product.dart';

part 'sale_product.g.dart';

@HiveType(typeId: 1)
class SaleProduct extends HiveObject {
  @HiveField(0)
  final Product product;

  @HiveField(1)
  double quantity;

  SaleProduct({
    required this.product,
    required this.quantity,
  });

  SaleProduct setQuantity(double mQuantity){
    quantity = mQuantity;
    return this;
  }
}
