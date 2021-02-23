import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viva/common/test/material_test_widget.dart';
import 'package:viva/data/models/__mocks__/todo_model_mock.dart';
import 'package:viva/presentation/journey/home/views/todo_widget.dart';
import 'package:viva/presentation/journey/home/views/view_constants.dart';
import 'package:viva/presentation/theme/theme_color.dart';

void main() {
  group('Todo widget ', () {
    testWidgets('Should render widget correctly', (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      final emptyWidget = TodoWidget(key: key, data: mockNormalTodoData);

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(emptyWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Then
      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('Should find all child widget correctly',
        (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      final emptyWidget = TodoWidget(key: key, data: mockNormalTodoData);

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(emptyWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final titleFinder = find.byKey(TodoWidgetConstant.titleKey);
      final descFinder = find.byKey(TodoWidgetConstant.descriptionKey);
      final btnDeleteFinder = find.byKey(TodoWidgetConstant.buttonDeleteKey);
      final btnDeleteIconFinder =
          find.byKey(TodoWidgetConstant.buttonDeleteIconKey);
      final btnDoneFinder = find.byKey(TodoWidgetConstant.buttonMarkAsDoneKey);
      final btnDoneIconFinder =
          find.byKey(TodoWidgetConstant.buttonMarkAsDoneIconKey);
      final btnNotDoneFinder =
          find.byKey(TodoWidgetConstant.buttonMarkAsDoneKey);
      final btnNotDoneIconFinder =
          find.byKey(TodoWidgetConstant.buttonMarkAsDoneIconKey);

      // Then
      expect(titleFinder, findsOneWidget);
      expect(descFinder, findsOneWidget);
      expect(btnDeleteFinder, findsOneWidget);
      expect(btnDeleteIconFinder, findsOneWidget);
      expect(btnDoneFinder, findsOneWidget);
      expect(btnDoneIconFinder, findsOneWidget);
      expect(btnNotDoneFinder, findsOneWidget);
      expect(btnNotDoneIconFinder, findsOneWidget);
    });

    testWidgets('Should render mark as done widget correctly',
        (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      final todoWidget = TodoWidget(key: key, data: mockDoneTodoData);

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(todoWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final doneFinder = find.byKey(TodoWidgetConstant.buttonMarkAsDoneIconKey);
      final widgetFinder = tester.firstWidget(doneFinder);

      // Then
      expect((widgetFinder as Icon).color, AppColor.primaryColor);
    });

    testWidgets('Should render mark as not done widget correctly',
        (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      final todoWidget = TodoWidget(key: key, data: mockNotDoneTodoData);

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(todoWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final doneFinder =
          find.byKey(TodoWidgetConstant.buttonMarkAsNotDoneIconKey);
      final widgetFinder = tester.firstWidget(doneFinder);

      // Then
      expect((widgetFinder as Icon).color, AppColor.primaryColor);
    });

    testWidgets('Should callback when tap delete button',
        (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      var isTapDelete = false;
      final todoWidget = TodoWidget(
        key: key,
        data: mockNotDoneTodoData,
        onDelete: (data) {
          isTapDelete = true;
        },
      );

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(todoWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final deleteFinder = find.byKey(TodoWidgetConstant.buttonDeleteKey);
      await tester.tap(deleteFinder);

      // Then
      expect(isTapDelete, true);
    });

    testWidgets('Should callback when tap mark done button',
        (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      var isTapMarkAsDone = false;
      final todoWidget = TodoWidget(
        key: key,
        data: mockNotDoneTodoData,
        onMarkAsDone: (data) {
          isTapMarkAsDone = true;
        },
      );

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(todoWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final doneFinder = find.byKey(TodoWidgetConstant.buttonMarkAsDoneKey);
      await tester.tap(doneFinder);

      // Then
      expect(isTapMarkAsDone, true);
    });

    testWidgets('Should callback when tap mark as not done button',
        (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      var isTapMarkAsNotDone = false;
      final todoWidget = TodoWidget(
        key: key,
        data: mockDeleteTodoData,
        onMarkAsNotDone: (data) {
          isTapMarkAsNotDone = true;
        },
      );

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(todoWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final notDoneFinder =
          find.byKey(TodoWidgetConstant.buttonMarkAsNotDoneKey);
      await tester.tap(notDoneFinder);

      // Then
      expect(isTapMarkAsNotDone, true);
    });
  });
}
