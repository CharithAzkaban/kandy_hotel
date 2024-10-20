import 'package:hive/hive.dart';

part 'deduction.g.dart';

@HiveType(typeId: 3)
class Deduction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime createdAt;

  Deduction({
    required this.id,
    required this.title,
    required this.amount,
    required this.createdAt,
  });
}
