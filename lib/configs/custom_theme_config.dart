import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeConfig {
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.blueGrey,
    onPrimary: Colors.black,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Color(0xFF322942),
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color(0xFFFAFBFB),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color.fromRGBO(191, 54, 12, 1),
    secondary: Color.fromRGBO(158, 37, 7, 1),
    surface: Color.fromARGB(255, 7, 7, 8),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );

  ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.aBeeZeeTextTheme(TextTheme(bodyLarge: TextStyle(color: Colors.black))),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    appBarTheme: AppBarTheme(
      color: Colors.deepOrange.shade900,
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.aBeeZeeTextTheme(TextTheme(bodyLarge: TextStyle(color: Colors.white))),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
