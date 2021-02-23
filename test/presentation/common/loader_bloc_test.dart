import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viva/presentation/common_bloc/loader_bloc/loader_bloc.dart';

void main() {
  group('Loader bloc test', () {
    blocTest(
      'should init success',
      build: () => LoaderBloc(),
      expect: [],
    );

    blocTest(
      'should emit event [Loading] when trigger',
      build: () => LoaderBloc(),
      act: (bloc) => bloc.add(ShowLoading()),
      expect: [
        isA<Loading>(),
      ],
    );

    blocTest(
      'should emit event [AddTodoSuccessState] when trigger',
      build: () => LoaderBloc(),
      act: (bloc) => bloc.add(HideLoading()),
      expect: [
        isA<Loaded>(),
      ],
    );
  });
}
