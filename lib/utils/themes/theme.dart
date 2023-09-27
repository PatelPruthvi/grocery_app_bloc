import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      cardColor: Colors.white,
      canvasColor: Colors.grey[100],
      primaryColor: Colors.black,
      indicatorColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.5,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: GoogleFonts.lato().fontFamily,
          )),
      fontFamily: GoogleFonts.lato().fontFamily);

  static ThemeData darkTheme = ThemeData(
      cardColor: Colors.black,
      canvasColor: Colors.grey[800],
      primaryColor: Colors.white,
      indicatorColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          elevation: 0.5,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: GoogleFonts.lato().fontFamily,
          )),
      fontFamily: GoogleFonts.lato().fontFamily);
}
