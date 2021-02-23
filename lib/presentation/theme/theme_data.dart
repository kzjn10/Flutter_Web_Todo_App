import 'package:flutter/material.dart';

import 'theme_color.dart';

ThemeData appTheme(BuildContext context) => ThemeData(
      fontFamily: 'GoogleSans',
      primaryColor: AppColor.primaryColor,
      accentColor: AppColor.accentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
        buttonColor: AppColor.primaryColor,
        splashColor: AppColor.buttonSplashColor,
        highlightColor: AppColor.primaryColor.withOpacity(.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      scaffoldBackgroundColor: AppColor.white,
      appBarTheme:
          const AppBarTheme(color: AppColor.primaryColor, elevation: 0.0),
      toggleableActiveColor: AppColor.primaryColor,
    );
