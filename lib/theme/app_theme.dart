import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Colors.redAccent;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      elevation: 10,
    )
  );
}