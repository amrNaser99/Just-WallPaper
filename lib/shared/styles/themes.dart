import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justwallpaper/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: colorDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    elevation: 0,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  fontFamily: 'fonts/janna.ttf',
  primaryColor: colorPrimary,


);
