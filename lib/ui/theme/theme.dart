import 'package:flutter/material.dart';

const primaryColor = Color(0xff202329);
const textColor = Color(0xffD0D0D0);

ThemeData themeData(context) {
  return ThemeData(
    fontFamily: 'Lato',
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        fontFamily: 'Anton',
        color: textColor,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xff121418),
    useMaterial3: true,
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: textColor,
          displayColor: textColor,
          fontFamily: 'Lato',
        ),
  );
}
