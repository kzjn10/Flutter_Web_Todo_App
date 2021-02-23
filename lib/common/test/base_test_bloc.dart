import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart' as bloc_test;

class BaseBlocTest<C extends Bloc<E, S>, E, S> {
  void test(String description,
      {@required C Function() build,
      Future<void> Function(C bloc) act,
      Duration wait,
      Future<void> Function(C cubit) verify,
      @required Iterable expect}) {
    return bloc_test.blocTest<C, S>(
      description,
      build: build,
      wait: wait,
      verify: verify,
      act: act,
      expect: expect,
    );
  }
}
