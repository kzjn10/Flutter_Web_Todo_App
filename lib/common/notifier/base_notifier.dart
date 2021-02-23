import 'package:flutter/material.dart';

class BaseValueChangeNotifier<T> extends ValueNotifier<T> {
  BaseValueChangeNotifier(T value) : super(value);
}
