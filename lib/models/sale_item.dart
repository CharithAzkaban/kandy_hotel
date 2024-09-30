import 'package:hive/hive.dart';
import 'package:kandy_hotel/models/product.dart';

part 'sale_item.g.dart';

@HiveType(typeId: 1)
class SaleItem extends HiveObject {
  @HiveField(0)
  final Product product;

  @HiveField(1)
  double quantity;

  SaleItem({
    required this.product,
    required this.quantity,
  });

  SaleItem setQuantity(double mQuantity){
    quantity = mQuantity;
    return this;
  }
}
