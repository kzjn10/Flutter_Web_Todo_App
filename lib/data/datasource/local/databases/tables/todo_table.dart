import 'package:hive/hive.dart';

import '../../../../../common/constants/local_database_type_constants.dart';
import '../../../../models/todo_model.dart';

part 'todo_table.g.dart';

@HiveType(typeId: HiveTypeIdConstants.todoTableId)
class TodoTable extends TodoModel {
  TodoTable({
    String id,
    String title,
    String description,
    bool isDone,
    bool isNotDone,
    bool isDeleted,
    int createdDate,
    int updatedDate,
  }) : super(
          id: id,
          title: title,
          description: description,
          isDone: isDone,
          isNotDone: isNotDone,
          isDeleted: isDeleted,
          createdDate: createdDate,
          updatedDate: updatedDate,
        );

  factory TodoTable.fromModel(TodoModel data) {
    return TodoTable(
      id: data.id,
      title: data.title,
      description: data.description,
      isDone: data.isDone,
      isNotDone: data.isNotDone,
      isDeleted: data.isDeleted,
      createdDate: data.createdDate,
      updatedDate: data.updatedDate,
    );
  }
}
