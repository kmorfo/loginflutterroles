import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDarkmode;
  final Color colorSeed;
  final Color scaffoldBackgroundColor;

  AppTheme({
    required this.isDarkmode,
    this.colorSeed = const Color(0xFFff5d5f),
    this.scaffoldBackgroundColor = const Color(0xFFF8F7F7),
  });

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorSeed,

        ///* Texts
        textTheme: TextTheme(
            titleLarge: GoogleFonts.montserratAlternates()
                .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
            titleMedium: GoogleFonts.montserratAlternates()
                .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            titleSmall: GoogleFonts.montserratAlternates().copyWith(fontSize: 22)),

        ///* AppBar
        appBarTheme: AppBarTheme(
          // color: scaffoldBackgroundColor,
          // elevation: 1,
          titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: isDarkmode ? Colors.white : Colors.black),
        ),

        ///* Buttons
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: MaterialStateProperty.all(30),
          ),
        ),
      );
}
