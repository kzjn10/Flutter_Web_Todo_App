import '../../../../../data/models/todo_model.dart';
import '../../../../../data/repositories/todo_repository.dart';
import '../home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final TodoRepository todoRepository;

  HomeRepositoryImpl({this.todoRepository});

  @override
  Future<void> addTodo(TodoModel data) async {
    await todoRepository.addTodo(data);
  }

  @override
  Future<List<TodoModel>> getAllTodo() async {
    final todoList = await todoRepository.getAllTodo();
    final temp = todoList?.where((element) => !element.isDeleted)?.toList() ??
        <TodoModel>[];
    temp.sort((a, b) => a.createdDate.compareTo(b.createdDate));
    return temp;
  }

  @override
  Future<void> updateTodo(TodoModel data) async {
    await todoRepository.updateTodo(data);
  }
}
