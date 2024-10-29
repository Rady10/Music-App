import 'package:flutter/material.dart';
import 'package:music/core/theme/app_pallete.dart';

class AppTheme{
  static _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3
    ),
    borderRadius: BorderRadius.circular(10)
  );
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      focusedBorder: _border(Pallete.gradient2),
      enabledBorder: _border(Pallete.borderColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor
    )
  );
  
}