// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) {
  return TodoModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    isDone: json['isDone'] as bool,
    isNotDone: json['isNotDone'] as bool,
    isDeleted: json['isDeleted'] as bool,
    createdDate: json['createdDate'] as int,
    updatedDate: json['updatedDate'] as int,
  );
}

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isDone': instance.isDone,
      'isNotDone': instance.isNotDone,
      'isDeleted': instance.isDeleted,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
    };
