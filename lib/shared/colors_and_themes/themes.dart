import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: buttonColor,
    ),
    titleTextStyle: TextStyle(
        color: lightTextColor,
        fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: buttonColor,
    unselectedItemColor: Colors.black,
    elevation: 0,
    unselectedLabelStyle: TextStyle(
      color: Colors.grey[400]
    ),
    // backgroundColor: Colors.black
    backgroundColor: Colors.white, // Soft light grey for a smooth transition
  ),
  iconTheme: IconThemeData(
    color: buttonColor,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      color: lightTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 30.0,
      height: 1.5,
      fontWeight: FontWeight.bold,
      color: lightTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 20.0,
      height: 1.5,
      fontWeight: FontWeight.bold,
      color: lightTextColor,
    ),
  ),
  fontFamily: 'MainFont',
);


ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[900],

  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[900],
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.grey[900],
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: darkTextColor,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white, // Ensure icons in AppBar are white
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey[500],
    backgroundColor: Colors.grey[900],
    elevation: 0,
  ),

  iconTheme: IconThemeData(
    color: Colors.white, // Makes all icons white in dark mode
  ),

  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      color: darkTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 30.0,
      height: 1.5,
      fontWeight: FontWeight.bold,
      color: darkTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 20.0,
      height: 1.5,
      fontWeight: FontWeight.bold,
      color: darkTextColor,
    ),
  ),

  cardTheme: CardTheme(
    color: Colors.grey[850], // Dark background for cards
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.white24), // Subtle white border
    ),
  ),

  fontFamily: 'MainFont',
);