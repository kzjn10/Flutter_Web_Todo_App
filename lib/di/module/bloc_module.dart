import '../../presentation/common_bloc/language_bloc/language_bloc.dart';
import '../../presentation/common_bloc/loader_bloc/loader_bloc.dart';
import '../../presentation/journey/home/bloc/todo_bloc.dart';
import '../../presentation/journey/home/interactor/impl/home_interactor_impl.dart';
import '../../presentation/journey/home/repositories/home_repository.dart';
import '../di_module.dart';
import '../injection/injection.dart';

class BlocModule extends LocatorModule {
  @override
  Future<void> provides() async {
    injector
      ..registerLazySingleton(() => LanguageBloc())
      ..registerLazySingleton(() => LoaderBloc())
      ..registerFactory(
        () => TodoBloc(
          loaderBloc: injector<LoaderBloc>(),
          homeInteractor:
              HomeInteractorImpl(homeRepository: injector<HomeRepository>()),
        ),
      );
  }
}
