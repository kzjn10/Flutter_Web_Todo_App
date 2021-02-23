import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viva/presentation/common_bloc/language_bloc/language_bloc.dart';

void main() {
  group('Language bloc test', () {
    blocTest(
      'should init success',
      build: () => LanguageBloc(),
      expect: [],
    );

    blocTest(
      'should emit event [StartAppState] when trigger',
      build: () => LanguageBloc(),
      act: (bloc) => bloc.add(StartAppEvent()),
      expect: [
        isA<StartAppState>(),
      ],
    );
  });
}
