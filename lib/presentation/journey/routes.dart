import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants/router_constants.dart';
import '../../di/injection/injection.dart';
import 'home/bloc/todo_bloc.dart';
import 'home/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.initial:
      case RouteName.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => injector<TodoBloc>(),
            child: HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
