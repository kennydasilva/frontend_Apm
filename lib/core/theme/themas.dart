import 'package:flutter/material.dart';
import 'package:projecto_final/core/theme/App_cores.dart';



class ThemaAPP{
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide:  BorderSide(
      color: color,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Cores.whiteColor,
    inputDecorationTheme: InputDecorationTheme(

      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(Cores.borderColor),
      focusedBorder:_border(Cores.gradient4),
    ),
  );
}