import '../../data/datasource/local/databases/local_datasource/todo_local_datasource.dart';
import '../../data/repositories/impl/todo_repo_impl.dart';
import '../../data/repositories/todo_repository.dart';
import '../../presentation/journey/home/repositories/home_repository.dart';
import '../../presentation/journey/home/repositories/impl/home_repository_impl.dart';
import '../di_module.dart';
import '../injection/injection.dart';

class RepositoryModule extends LocatorModule {
  @override
  Future<void> provides() async {
    injector
      ..registerFactory<TodoRepository>(() => TodoRepositoryImpl(
          todoLocalDataSource: injector.get<TodoLocalDataSource>()))
      ..registerFactory<HomeRepository>(() =>
          HomeRepositoryImpl(todoRepository: injector.get<TodoRepository>()));
  }
}
