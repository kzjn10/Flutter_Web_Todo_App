import '../../data/datasource/local/databases/local_datasource/todo_local_datasource.dart';
import '../di_module.dart';
import '../injection/injection.dart';

class LocalDatasourceModule extends LocatorModule {
  @override
  Future<void> provides() async {
    injector.registerFactory(() => TodoLocalDataSource());
  }
}
