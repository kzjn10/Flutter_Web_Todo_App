import '../models/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getAllTodo();

  Future<void> updateTodo(TodoModel data);

  Future<void> addTodo(TodoModel data);
}
