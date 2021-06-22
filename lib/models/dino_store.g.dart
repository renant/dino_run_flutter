// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dino_store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DinoStoreAdapter extends TypeAdapter<DinoStore> {
  @override
  final int typeId = 0;

  @override
  DinoStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DinoStore(
      name: fields[0] as String,
      asset: fields[1] as String,
      id: fields[2] as String,
      isSelected: fields[3] as bool,
      isPurchased: fields[4] as bool,
      price: fields[5] as int,
      dinoType: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DinoStore obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.asset)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isSelected)
      ..writeByte(4)
      ..write(obj.isPurchased)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.dinoType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DinoStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
