part of 'loader_bloc.dart';

abstract class LoaderEvent {}

class ShowLoading extends LoaderEvent {
  ShowLoading();
}

class HideLoading extends LoaderEvent {
  HideLoading();
}
