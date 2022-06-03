// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletedTaskAdapter extends TypeAdapter<CompletedTask> {
  @override
  final int typeId = 2;

  @override
  CompletedTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedTask(
      taskTitle: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedTask obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.taskTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
