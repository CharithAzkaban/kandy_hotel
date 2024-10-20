import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double buyingPrice;

  @HiveField(3)
  double sellingPrice;

  @HiveField(4)
  double avbQuantity;

  Product({
    required this.id,
    required this.name,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.avbQuantity,
  });

  Product changeQuantity(double quantity) => Product(
        id: id,
        name: name,
        buyingPrice: buyingPrice,
        sellingPrice: sellingPrice,
        avbQuantity: quantity,
      );
}
