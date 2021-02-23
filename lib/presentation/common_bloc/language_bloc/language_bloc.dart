import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(StartAppState());

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    switch (event.runtimeType) {
      case StartAppEvent:
        yield StartAppState();
        break;
      default:
        break;
    }
  }
}
