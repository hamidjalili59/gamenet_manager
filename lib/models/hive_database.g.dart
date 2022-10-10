// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDatabaseAdapter extends TypeAdapter<HiveDatabase> {
  @override
  final int typeId = 1;

  @override
  HiveDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDatabase(
      date: fields[0] as DateTime,
      consoleName: fields[1] as String,
      consoleData: (fields[2] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveDatabase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.consoleName)
      ..writeByte(2)
      ..write(obj.consoleData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
