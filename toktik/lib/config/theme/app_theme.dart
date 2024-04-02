import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(centerTitle: true));
}
