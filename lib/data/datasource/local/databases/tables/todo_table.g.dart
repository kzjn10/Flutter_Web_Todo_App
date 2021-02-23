// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoTableAdapter extends TypeAdapter<TodoTable> {
  @override
  final int typeId = 1;

  @override
  TodoTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoTable(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      isDone: fields[3] as bool,
      isNotDone: fields[4] as bool,
      isDeleted: fields[5] as bool,
      createdDate: fields[6] as int,
      updatedDate: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TodoTable obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.isNotDone)
      ..writeByte(5)
      ..write(obj.isDeleted)
      ..writeByte(6)
      ..write(obj.createdDate)
      ..writeByte(7)
      ..write(obj.updatedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
