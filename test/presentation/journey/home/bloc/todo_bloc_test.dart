import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:viva/data/datasource/local/databases/local_datasource/todo_local_datasource.dart';
import 'package:viva/data/models/__mocks__/todo_model_mock.dart';
import 'package:viva/data/repositories/impl/todo_repo_impl.dart';
import 'package:viva/presentation/common_bloc/loader_bloc/loader_bloc.dart';
import 'package:viva/presentation/journey/home/bloc/todo_bloc.dart';
import 'package:viva/presentation/journey/home/interactor/impl/home_interactor_impl.dart';
import 'package:viva/presentation/journey/home/repositories/impl/home_repository_impl.dart';

void main() {
  group('Todo bloc test', () {
    const baseLocation = './local_database_test_files/';
    Hive.init(baseLocation);
    TodoLocalDataSource todoLocalDataSource;
    Box box;

    setUpAll(() async {
      todoLocalDataSource = TodoLocalDataSource();
      await todoLocalDataSource.deleteAll();
      box = await todoLocalDataSource.boxInstance;
    });

    tearDown(() async {
      await box.clear();
    });

    blocTest(
      'should init success',
      build: () => TodoBloc(
        loaderBloc: LoaderBloc(),
        homeInteractor: HomeInteractorImpl(
          homeRepository: HomeRepositoryImpl(
            todoRepository: TodoRepositoryImpl(),
          ),
        ),
      ),
      expect: [],
    );

    blocTest(
      'should emit event [AddTodoSuccessState] when trigger',
      build: () => TodoBloc(
        loaderBloc: LoaderBloc(),
        homeInteractor: HomeInteractorImpl(
          homeRepository: HomeRepositoryImpl(
            todoRepository:
                TodoRepositoryImpl(todoLocalDataSource: TodoLocalDataSource()),
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        AddTodoEvent(
          title: 'abc',
          desc: 'def',
        ),
      ),
      expect: [
        isA<AddTodoSuccessState>(),
      ],
    );

    blocTest(
      'should show message when submit invalid data',
      build: () => TodoBloc(
        loaderBloc: LoaderBloc(),
        homeInteractor: HomeInteractorImpl(
          homeRepository: HomeRepositoryImpl(
            todoRepository:
                TodoRepositoryImpl(todoLocalDataSource: TodoLocalDataSource()),
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        AddTodoEvent(
          title: '',
          desc: 'def',
        ),
      ),
      expect: [],
    );

    blocTest(
      'should emit event [FetchingTodoListSuccessState] after load success',
      build: () => TodoBloc(
        loaderBloc: LoaderBloc(),
        homeInteractor: HomeInteractorImpl(
          homeRepository: HomeRepositoryImpl(
            todoRepository: TodoRepositoryImpl(
              todoLocalDataSource: TodoLocalDataSource(),
            ),
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        FetchAllTodoEvent(),
      ),
      expect: [
        isA<FetchingTodoListState>(),
        isA<FetchingTodoListSuccessState>(),
      ],
    );

    blocTest(
      'should emit event [FetchingTodoListSuccessState] '
      'after trigger [DeleteTodoEvent]',
      build: () => TodoBloc(
        loaderBloc: LoaderBloc(),
        homeInteractor: HomeInteractorImpl(
          homeRepository: HomeRepositoryImpl(
            todoRepository: TodoRepositoryImpl(
              todoLocalDataSource: TodoLocalDataSource(),
            ),
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        DeleteTodoEvent(todoData: mockDeleteTodoData),
      ),
      expect: [
        isA<FetchingTodoListSuccessState>(),
      ],
    );

    blocTest(
      'should emit event [FetchingTodoListSuccessState] '
      'after trigger [MarkTodoEvent]',
      build: () => TodoBloc(
        loaderBloc: LoaderBloc(),
        homeInteractor: HomeInteractorImpl(
          homeRepository: HomeRepositoryImpl(
            todoRepository: TodoRepositoryImpl(
              todoLocalDataSource: TodoLocalDataSource(),
            ),
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        MarkTodoEvent(todoData: mockNotDoneTodoData),
      ),
      expect: [
        isA<FetchingTodoListSuccessState>(),
      ],
    );
  });
}
