import '../../datasource/local/databases/local_datasource/todo_local_datasource.dart';
import '../../models/todo_model.dart';
import '../todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource todoLocalDataSource;

  TodoRepositoryImpl({this.todoLocalDataSource});

  @override
  Future<void> addTodo(TodoModel data) async {
    await todoLocalDataSource.insertOrUpdateItem(data);
  }

  @override
  Future<List<TodoModel>> getAllTodo() {
    return todoLocalDataSource.getFormattedData();
  }

  @override
  Future<void> updateTodo(TodoModel data) async {
    await todoLocalDataSource.insertOrUpdateItem(data);
  }
}
