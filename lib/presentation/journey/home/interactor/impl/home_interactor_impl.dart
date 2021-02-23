import '../../../../../data/models/todo_model.dart';
import '../../repositories/home_repository.dart';
import '../home_interactor.dart';

class HomeInteractorImpl implements HomeInteractor {
  final HomeRepository homeRepository;

  HomeInteractorImpl({this.homeRepository});

  @override
  Future<void> addTodo(TodoModel data) async {
    await homeRepository.addTodo(data);
  }

  @override
  Future<List<TodoModel>> getAllTodo() {
    return homeRepository.getAllTodo();
  }

  @override
  Future<void> updateTodo(TodoModel data) async {
    await homeRepository.updateTodo(data);
  }
}
