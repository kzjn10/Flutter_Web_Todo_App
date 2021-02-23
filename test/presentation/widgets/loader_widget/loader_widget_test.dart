import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viva/common/test/material_test_widget.dart';
import 'package:viva/presentation/common_bloc/loader_bloc/__mock__/loader_bloc_mock.dart';
import 'package:viva/presentation/common_bloc/loader_bloc/loader_bloc.dart';
import 'package:viva/presentation/widgets/loader_widget/loader_widget.dart';

NavigatorObserver mockObserver;

void main() {
  LoaderBloc loaderBloc;

  setUp(() {
    loaderBloc = MockLoaderBloc();
  });

  group('Loader screen', () {
    testWidgets('App should have loading container in a non visible state',
        (WidgetTester tester) async {
      when(loaderBloc.state).thenAnswer((_) {
        return Loaded();
      });
      await _buildLoaderScreen(tester, loaderBloc);
      final loadingContainer = find.byKey(const ValueKey('container'));
      expect(loadingContainer, findsOneWidget);
      expect(find.byKey(const ValueKey('loadingContent')), findsNothing);
    });

    testWidgets('App should have loading container in a visible state',
        (WidgetTester tester) async {
      when(loaderBloc.state).thenAnswer((_) {
        return Loading();
      });
      await _buildLoaderScreen(tester, loaderBloc);
      final loadingContainer = find.byKey(const ValueKey('container'));
      expect(loadingContainer, findsOneWidget);
      expect(find.byKey(const ValueKey('loadingContent')), findsOneWidget);
    });
  });
}

Future<void> _buildLoaderScreen(
    WidgetTester tester, MockLoaderBloc loaderBloc) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoaderBloc>.value(
          value: loaderBloc,
        )
      ],
      child: wrapWidgetWithoutNavigation(
        const LoadingContainer(
          key: ValueKey('container'),
          child: Text('hi'),
        ),
      ),
    ),
  );
}
