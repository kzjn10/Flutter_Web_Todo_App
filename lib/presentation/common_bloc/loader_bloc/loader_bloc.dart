import 'package:flutter_bloc/flutter_bloc.dart';

part 'loader_event.dart';

part 'loader_state.dart';

class LoaderBloc extends Bloc<LoaderEvent, LoaderState> {
  LoaderBloc() : super(Loaded());

  @override
  Stream<LoaderState> mapEventToState(LoaderEvent event) async* {
    switch (event.runtimeType) {
      case ShowLoading:
        yield Loading();
        break;
      case HideLoading:
        yield Loaded();
        break;
    }
  }
}
