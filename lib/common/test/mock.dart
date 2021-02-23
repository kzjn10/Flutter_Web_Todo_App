import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

enum MockMediaQueryType {
  defaultSize,
  zeroSize,
  customSize,
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockFunction extends Mock {
  void navigate();
  void callback();
}

class MockLifecycleEventHandler extends Mock {
  AsyncCallback onResume();
  AsyncCallback onInactive();
  AsyncCallback onPaused();
  AsyncCallback onDetached();
}
