import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../datasource/local/databases/tables/todo_table.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  bool isDone;
  @HiveField(4)
  bool isNotDone;
  @HiveField(5)
  bool isDeleted;
  @HiveField(6)
  int createdDate;
  @HiveField(7)
  int updatedDate;

  TodoModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.isDone,
    @required this.isNotDone,
    @required this.isDeleted,
    @required this.createdDate,
    @required this.updatedDate,
  });

  factory TodoModel.fromTable(TodoTable table) {
    return TodoModel(
      id: table.id,
      title: table.title,
      description: table.description,
      isDone: table.isDone,
      isNotDone: table.isNotDone,
      isDeleted: table.isDeleted,
      createdDate: table.createdDate,
      updatedDate: table.updatedDate,
    );
  }
}
