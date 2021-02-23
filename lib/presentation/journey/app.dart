import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/constants/app_constants.dart';
import '../../common/constants/router_constants.dart';
import '../../di/injection/injection.dart';
import '../common_bloc/language_bloc/language_bloc.dart';
import '../common_bloc/loader_bloc/loader_bloc.dart';
import '../theme/theme_data.dart';
import '../widgets/loader_widget/loader_widget.dart';
import 'routes.dart';

class VivaApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  final _botToastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MultiBlocProvider(
        providers: _getProviders(),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(
                AppConstants.screenWidth,
                AppConstants.screenHeight,
              ),
              allowFontScaling: AppConstants.allowFontScaling,
              builder: () => MaterialApp(
                title: 'Note App',
                theme: appTheme(context),
                initialRoute: RouteName.initial,
                debugShowCheckedModeBanner: false,
                navigatorKey: _navigator,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                  localizationDelegate,
                ],
                supportedLocales: localizationDelegate.supportedLocales,
                locale: localizationDelegate.currentLocale,
                onGenerateRoute: Routes.generateRoute,
                builder: (context, child) {
                  child = LoadingContainer(
                    navigator: _navigator,
                    child: child,
                  );

                  return _botToastBuilder(context, child);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  List<BlocProvider> _getProviders() => [
        BlocProvider<LanguageBloc>(
            create: (BuildContext context) => injector<LanguageBloc>()),
        BlocProvider<LoaderBloc>(
            create: (BuildContext context) => injector<LoaderBloc>())
      ];
}
