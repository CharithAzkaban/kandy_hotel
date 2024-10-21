// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReturnProductAdapter extends TypeAdapter<ReturnProduct> {
  @override
  final int typeId = 4;

  @override
  ReturnProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReturnProduct(
      id: fields[0] as String,
      product: fields[1] as Product,
      quantity: fields[2] as double,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ReturnProduct obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.product)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReturnProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
