// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleProductAdapter extends TypeAdapter<SaleProduct> {
  @override
  final int typeId = 1;

  @override
  SaleProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleProduct(
      product: fields[0] as Product,
      quantity: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SaleProduct obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
