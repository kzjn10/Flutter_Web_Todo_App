import 'package:hive/hive.dart';
import 'package:test/test.dart';
import 'package:viva/data/datasource/local/databases/local_datasource/todo_local_datasource.dart';
import 'package:viva/data/datasource/local/databases/tables/__mock__/todo_mock.dart';
import 'package:viva/data/datasource/local/databases/tables/todo_table.dart';
import 'package:viva/data/models/__mocks__/todo_model_mock.dart';
import 'package:viva/data/models/todo_model.dart';

void main() {
  group('Todo local datasource', () {
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

    test(
        'should return todo items when getFormattedData is called. '
        'Given that box contains one record', () async {
      // Given
      await box.add(todoTableMock);

      // When
      final todoList = await todoLocalDataSource.getFormattedData();

      // Then
      expect(todoList.length, 1);
      expect(todoList.first.id, todoTableMock.id);
    });

    test(
        'box should contain one record '
        'when insertOrUpdateItem is called with one item', () async {
      // When
      await todoLocalDataSource.insertOrUpdateItem(mockNotDoneTodoData);

      // Then
      expect(box.toMap().length, 1);
      expect(box.toMap().containsKey(mockNotDoneTodoData.id), true);

      final TodoTable todoTable = box.toMap().values.toList()[0];
      expect(todoTable.id, mockNotDoneTodoData.id);
    });

    test(
        'box should contain one record '
        'when insertOrUpdateItems is called with one item', () async {
      // When
      await todoLocalDataSource.insertOrUpdateItems(
          <TodoModel>[mockNotDoneTodoData, mockInsertTodoData]);

      // Then
      expect(box.toMap().length, 2);
      expect(box.toMap().containsKey(mockNotDoneTodoData.id), true);

      final TodoTable todoTable = box.toMap().values.toList()[0];
      expect(todoTable.id, mockNotDoneTodoData.id);
    });

    test(
        'box should return one record district item by code'
        'given the box contain the record'
        'when getFormattedDataByKey is called with the code', () async {
      // Given
      await box.put('123', todoTableMock);

      // When
      final todoModel = await todoLocalDataSource.getFormattedDataByKey('123');

      // Then
      expect(todoModel.id, todoTableMock.id);
      expect(todoModel.title, todoTableMock.title);
      expect(todoModel.description, todoTableMock.description);
    });
  });
}
