import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viva/di/injection/injection.dart';
import 'package:viva/presentation/common_bloc/loader_bloc/loader_bloc.dart';
import 'package:viva/presentation/journey/home/bloc/todo_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('should provide success bloc DI', () async {
    expect(injector.isRegistered<LoaderBloc>(), false);
    await Injection.setUpLocator();
    expect(injector.isRegistered<LoaderBloc>(), true);
    expect(injector<LoaderBloc>() is LoaderBloc, true);

    expect(injector.isRegistered<TodoBloc>(), true);
  });
}
