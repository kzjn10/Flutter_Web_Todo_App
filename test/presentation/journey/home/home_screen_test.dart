import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viva/common/test/material_test_widget.dart';
import 'package:viva/data/models/__mocks__/todo_model_mock.dart';
import 'package:viva/data/models/todo_model.dart';
import 'package:viva/di/injection/injection.dart';
import 'package:viva/presentation/journey/home/bloc/__mock__/todo_bloc_mock.dart';
import 'package:viva/presentation/journey/home/bloc/todo_bloc.dart';
import 'package:viva/presentation/journey/home/home_screen.dart';
import 'package:viva/presentation/journey/home/home_screen_constants.dart';
import 'package:viva/presentation/journey/home/views/todo_widget.dart';

void main() {
  TodoBloc todoBlocMock;
  LocalizationDelegate delegate;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await Injection.setUpLocator();
    todoBlocMock = TodoBlocMock();
    delegate = await LocalizationDelegate.create(
        basePath: 'res/languages/',
        fallbackLocale: 'en',
        supportedLocales: ['en', 'vi']);
  });

  tearDown(() {
    todoBlocMock?.close();
  });

  Future<void> _buildInitTodoList(WidgetTester tester) async {
    when(todoBlocMock.state).thenAnswer((_) => InitState());

    final child = MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => todoBlocMock,
        ),
      ],
      child: HomeScreen(),
    );

    await tester.pumpWidget(wrapWidgetWithLocalization(child, delegate));
  }

  Future<void> _buildFetchEmptyTodoList(WidgetTester tester) async {
    when(todoBlocMock.state).thenAnswer((_) => FetchingTodoListSuccessState(
          state: InitState(),
          todoList: List.empty(),
        ));

    final child = MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => todoBlocMock,
        ),
      ],
      child: HomeScreen(),
    );

    await tester.pumpWidget(MaterialApp(
      home: child,
    ));
  }

  Future<void> _buildFetchTodoListSuccess(WidgetTester tester) async {
    when(todoBlocMock.state).thenAnswer((_) => FetchingTodoListSuccessState(
          state: InitState(),
          todoList: <TodoModel>[mockNormalTodoData],
        ));

    final child = MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => todoBlocMock,
        ),
      ],
      child: HomeScreen(),
    );

    await tester.pumpWidget(MaterialApp(
      home: child,
    ));
  }

  Future<void> _buildFetchEmptyTodoListSuccess(WidgetTester tester) async {
    when(todoBlocMock.state).thenAnswer((_) => FetchingTodoListSuccessState(
          state: InitState(),
          todoList: List.empty(),
        ));

    final child = MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => todoBlocMock,
        ),
      ],
      child: HomeScreen(),
    );

    await tester.pumpWidget(MaterialApp(
      home: child,
    ));
  }

  Future<void> _buildAddTodoSuccess(WidgetTester tester) async {
    when(todoBlocMock.state).thenAnswer((_) => AddTodoSuccessState(
          state: InitState(),
          todoList: <TodoModel>[mockNormalTodoData, mockNormalTodoData],
        ));

    final child = MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => todoBlocMock,
        ),
      ],
      child: HomeScreen(),
    );

    await tester.pumpWidget(MaterialApp(
      home: child,
    ));
  }

  group('Home screen test', () {
    testWidgets('Should init widget correctly', (WidgetTester tester) async {
      // Given

      // When
      await _buildInitTodoList(tester);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.emptyWidgetKey), findsOneWidget);
      expect(find.byKey(HomeScreenConstants.appbarKey), findsOneWidget);
      expect(find.byKey(HomeScreenConstants.fabKey), findsOneWidget);
    });

    testWidgets('Should init empty then tap add new todo',
        (WidgetTester tester) async {
      // Given

      // When
      await _buildInitTodoList(tester);
      await tester.pumpAndSettle();

      final emptyWidgetFinder = find.byKey(HomeScreenConstants.emptyWidgetKey);
      await tester.tap(emptyWidgetFinder);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.addTodoDialogKey), findsOneWidget);
    });

    testWidgets('Should render empty widget correctly',
        (WidgetTester tester) async {
      // Given

      // When
      await _buildFetchEmptyTodoList(tester);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.appbarKey), findsOneWidget);
      expect(find.byKey(HomeScreenConstants.fabKey), findsOneWidget);
    });

    testWidgets('Should render widget correctly', (WidgetTester tester) async {
      // Given

      // When
      await _buildFetchTodoListSuccess(tester);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.appbarKey), findsOneWidget);
      expect(find.byKey(HomeScreenConstants.fabKey), findsOneWidget);
    });

    testWidgets(
        'Should render empty todo list after fetch success '
        'then tap add new todo', (WidgetTester tester) async {
      // Given

      // When
      await _buildFetchEmptyTodoListSuccess(tester);
      await tester.pumpAndSettle();

      final emptyWidgetFinder = find.byKey(HomeScreenConstants.emptyWidgetKey);
      await tester.tap(emptyWidgetFinder);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.addTodoDialogKey), findsOneWidget);
    });

    testWidgets('Should render widget correctly when add todo success',
        (WidgetTester tester) async {
      // Given

      // When
      await _buildAddTodoSuccess(tester);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.appbarKey), findsOneWidget);
      expect(find.byKey(HomeScreenConstants.fabKey), findsOneWidget);
    });

    testWidgets('Should show add todo dialog when tap FAB',
        (WidgetTester tester) async {
      // Given

      // When
      await _buildFetchTodoListSuccess(tester);
      await tester.pumpAndSettle();

      final fabFinder = find.byKey(HomeScreenConstants.fabKey);
      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.addTodoDialogKey), findsOneWidget);
    });

    testWidgets(
        'Should show add todo dialog when tap FAB '
        'then tap Cancel button', (WidgetTester tester) async {
      // Given

      // When
      await _buildFetchTodoListSuccess(tester);
      await tester.pumpAndSettle();

      final fabFinder = find.byKey(HomeScreenConstants.fabKey);
      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      final btnCancelFinder =
          find.byKey(HomeScreenConstants.cancelBtnDialogKey);

      await tester.tap(btnCancelFinder);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(HomeScreenConstants.addTodoDialogKey), findsNothing);
    });

    testWidgets(
        'Should show add todo dialog when tap FAB '
        'then fill data and verify input data', (WidgetTester tester) async {
      // Given
      const titleText = 'This is title';
      const descText = 'This is desc';

      // When
      await _buildFetchTodoListSuccess(tester);
      await tester.pumpAndSettle();

      final fabFinder = find.byKey(HomeScreenConstants.fabKey);
      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      final titleFinder = find.byKey(HomeScreenConstants.titleDialogKey);
      final descFinder = find.byKey(HomeScreenConstants.descDialogKey);

      await tester.enterText(titleFinder, titleText);
      await tester.enterText(descFinder, descText);

      await tester.pumpAndSettle();

      // Then
      expect(find.text(titleText), findsOneWidget);
      expect(find.text(descText), findsOneWidget);
    });

    testWidgets(
        'Should show add todo dialog when tap FAB '
        'then fill data'
        'then tap add new todo', (WidgetTester tester) async {
      // Given
      const titleText = 'This is title';
      const descText = 'This is desc';

      // When
      await _buildInitTodoList(tester);
      await tester.pumpAndSettle();

      final fabFinder = find.byKey(HomeScreenConstants.fabKey);
      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      final titleFinder = find.byKey(HomeScreenConstants.titleDialogKey);
      final descFinder = find.byKey(HomeScreenConstants.descDialogKey);
      final btnAddFinder = find.byKey(HomeScreenConstants.addBtnDialogKey);

      await tester.enterText(titleFinder, titleText);
      await tester.enterText(descFinder, descText);

      await tester.pumpAndSettle();

      await tester.tap(btnAddFinder);
      await tester.pump();

      // Then
      expect(find.byKey(HomeScreenConstants.addTodoDialogKey), findsOneWidget);
    });

    testWidgets('Should render correct item on grid',
        (WidgetTester tester) async {
      // Given

      // When
      await _buildFetchTodoListSuccess(tester);
      await tester.pumpAndSettle();

      final fabFinder = find.byKey(HomeScreenConstants.fabKey);
      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      await tester.pumpAndSettle();

      // Then
      expect(find.byType(TodoWidget), findsNWidgets(1));
    });
  });
}
