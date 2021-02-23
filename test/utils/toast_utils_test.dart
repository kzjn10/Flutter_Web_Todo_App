import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viva/common/test/material_test_widget.dart';
import 'package:viva/presentation/widgets/toast_widget/toast_widget_enum.dart';
import 'package:viva/utils/toast_utils.dart';

void main() {
  Future click(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('main')));
    await tester.pump();
    await tester.pump();
    await tester.pump();
  }

  group('Toast utils test', () {
    testWidgets('should show fail toast', (WidgetTester tester) async {
      // Given
      const message = 'Error message';

      await tester.pumpWidget(ToastMockApp(
        callback: () {
          ToastUtils.show(message: message, type: ToastEnum.error);
        },
      ));

      // When
      await click(tester);

      // Then
      expect(find.text(message), findsOneWidget);
    });
  });

  testWidgets('should show warning toast', (WidgetTester tester) async {
    // Given
    const message = 'Warning message';

    await tester.pumpWidget(ToastMockApp(
      callback: () {
        ToastUtils.show(message: message, type: ToastEnum.warning);
      },
    ));

    // When
    await click(tester);

    // Then
    expect(find.text(message), findsOneWidget);
  });

  testWidgets('should show success toast', (WidgetTester tester) async {
    // Given
    const message = 'Success message';

    await tester.pumpWidget(ToastMockApp(
      callback: () {
        ToastUtils.show(message: message, type: ToastEnum.success);
      },
    ));

    // When
    await click(tester);

    // Then
    expect(find.text(message), findsOneWidget);
  });

  testWidgets('should show info toast', (WidgetTester tester) async {
    // Given
    const message = 'Info message';

    await tester.pumpWidget(ToastMockApp(
      callback: () {
        ToastUtils.show(message: message, type: ToastEnum.info);
      },
    ));

    // When
    await click(tester);

    // Then
    expect(find.text(message), findsOneWidget);
  });

  testWidgets('should show network error toast', (WidgetTester tester) async {
    // Given
    const message = 'Network error message';

    await tester.pumpWidget(ToastMockApp(
      callback: () {
        ToastUtils.show(message: message, type: ToastEnum.networkError);
      },
    ));

    // When
    await click(tester);

    // Then
    expect(find.text(message), findsOneWidget);
  });

  testWidgets('should show default toast', (WidgetTester tester) async {
    // Given
    const message = 'Default message';

    await tester.pumpWidget(ToastMockApp(
      callback: () {
        ToastUtils.show(message: message, type: ToastEnum.undefine);
      },
    ));

    // When
    await click(tester);

    // Then
    expect(find.text(message), findsOneWidget);
  });
}
