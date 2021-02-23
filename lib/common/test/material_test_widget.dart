import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';

import 'mock.dart';

Widget wrapWidgetWithScaffold(
  Widget widget, {
  MockMediaQueryType mockMediaQueryType,
  MediaQueryData mediaQueryData,
}) {
  return MaterialApp(
    home: Scaffold(body: widget),
  );
}

Widget wrapWidget(Widget widget, NavigatorObserver observer) {
  return MaterialApp(
    home: widget,
    navigatorObservers: [observer],
  );
}

Widget wrapWidgetWithoutNavigation(Widget widget) {
  return MaterialApp(
    home: widget,
  );
}

Widget wrapWidgetWithLocalization(
    Widget widget, LocalizationDelegate delegate) {
  return LocalizedApp(
    delegate,
    MaterialApp(
      home: widget,
    ),
  );
}

class ToastMockApp extends StatelessWidget {
  final VoidCallback callback;
  final void Function(BuildContext ctx) contextCallback;
  final Widget child;

  ToastMockApp({this.callback, this.child, this.contextCallback});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BotToast Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (ctx) => TextButton(
                key: const ValueKey('main'),
                onPressed: () async {
                  callback?.call();
                  contextCallback?.call(ctx);
                },
                child: const Text(''),
              ),
            ),
            child
          ]..removeWhere((test) => test == null),
        ),
      ),
    );
  }
}
