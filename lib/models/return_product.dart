import 'package:hive/hive.dart';
import 'package:kandy_hotel/models/product.dart';

part 'return_product.g.dart';

@HiveType(typeId: 4)
class ReturnProduct extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final Product product;

  @HiveField(2)
  final double quantity;

  @HiveField(3)
  final DateTime createdAt;

  ReturnProduct({
    required this.id,
    required this.product,
    required this.quantity,
    required this.createdAt,
  });
}
