part of 'loader_bloc.dart';

abstract class LoaderState {
  final bool loading;
  LoaderState({this.loading});
}

class Loading extends LoaderState {
  Loading() : super(loading: true);
}

class Loaded extends LoaderState {
  Loaded() : super(loading: false);
}
