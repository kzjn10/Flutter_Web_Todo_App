import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pedantic/pedantic.dart';

import 'di/injection/injection.dart';
import 'presentation/journey/app.dart';
import 'utils/database_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(DatabaseUtil.initDatabase());

  /// Disable all log from app when release
  if (kReleaseMode) {
    debugPrint = (String message, {int wrapWidth}) {};
  }

  await Injection.setUpLocator();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final delegate = await LocalizationDelegate.create(
      basePath: 'res/languages/',
      fallbackLocale: 'en',
      supportedLocales: ['en', 'vi']);

  runZoned(() {
    runApp(
      LocalizedApp(
        delegate,
        VivaApp(),
      ),
    );
  });
}
