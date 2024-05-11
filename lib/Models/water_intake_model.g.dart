// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_intake_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterIntakeModelAdapter extends TypeAdapter<WaterIntakeModel> {
  @override
  final int typeId = 0;

  @override
  WaterIntakeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterIntakeModel(
      drinkName: fields[0] as String,
      drinkSize: fields[1] as String,
      dateTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WaterIntakeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.drinkName)
      ..writeByte(1)
      ..write(obj.drinkSize)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterIntakeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
