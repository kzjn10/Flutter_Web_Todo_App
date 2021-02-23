import 'package:flutter/material.dart';

BoxDecoration todoItemDecoration({
  Color backgroundColor,
  double radius,
}) =>
    BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.0)),
      color: backgroundColor,
    );
