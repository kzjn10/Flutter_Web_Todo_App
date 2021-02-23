import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viva/common/test/material_test_widget.dart';
import 'package:viva/presentation/journey/home/views/empty_note_widget.dart';

void main() {
  group('Empty todo widget test', () {
    testWidgets('Should render correctly', (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      final emptyWidget = EmptyNoteWidget(
        key: key,
        onItemInteraction: () {},
      );

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(emptyWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Then
      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('Should callback when tap', (WidgetTester tester) async {
      // Given
      const key = ValueKey('widget_key');
      var isTaped = false;
      final emptyWidget = EmptyNoteWidget(
        key: key,
        onItemInteraction: () {
          isTaped = true;
        },
      );

      // When
      await tester.pumpWidget(wrapWidgetWithScaffold(emptyWidget));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final inkwellFinder = find.byType(InkWell);
      await tester.tap(inkwellFinder);

      // Then
      expect(isTaped, true);
    });
  });
}
