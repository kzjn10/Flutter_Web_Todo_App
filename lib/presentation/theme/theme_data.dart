import 'package:flutter/material.dart';

ThemeData buildAppTheme(BuildContext context, Brightness brightness) =>
    ThemeData(
      primarySwatch: Colors.amber,
      brightness: brightness,
      fontFamily: 'GoogleSans',
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
