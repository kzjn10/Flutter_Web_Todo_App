import '../../../../data/models/todo_model.dart';

abstract class HomeInteractor {
  Future<List<TodoModel>> getAllTodo();

  Future<void> updateTodo(TodoModel data);

  Future<void> addTodo(TodoModel data);
}
