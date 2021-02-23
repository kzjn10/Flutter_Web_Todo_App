import '../../../../../common/constants/local_datasource_boxname_constants.dart';
import '../../../../../utils/database_utils.dart';
import '../../../../models/todo_model.dart';
import '../tables/todo_table.dart';
import 'base_local_datasource.dart';

class TodoLocalDataSource extends BaseLocalDataSource<TodoTable, TodoModel> {
  TodoLocalDataSource() : super(boxName: LocalDataSourceBoxNameConstants.todo) {
    DatabaseUtil.registerAdapter<TodoTable>(TodoTableAdapter());
  }

  @override
  Future<List<TodoModel>> getFormattedData() async {
    final todoTableList = await getAll();
    return todoTableList.map((item) => TodoModel.fromTable(item)).toList();
  }

  @override
  Future<void> insertOrUpdateItems(List<TodoModel> todoList) async {
    if (todoList != null) {
      final todoTableMap = {
        for (final todoModel in todoList)
          todoModel.id: TodoTable.fromModel(todoModel)
      };
      await putAll(todoTableMap);
    }
  }

  Future<void> insertOrUpdateItem(TodoModel todoModel) async {
    final todoTable = TodoTable.fromModel(todoModel);
    await put(todoModel.id, todoTable);
  }

  Future<TodoModel> getFormattedDataByKey(String key) async {
    final todoTable = await get(key);
    if (todoTable != null) {
      return TodoModel.fromTable(todoTable);
    }
    return null;
  }
}
