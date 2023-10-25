import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeModel {
  final lightMode = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: HexColor("#8b7c61"),
    iconTheme: IconThemeData(color: HexColor("#8b7c61")),
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: HexColor("#8b7c61"),
    brightness: Brightness.light,
    primaryColorLight: Colors.white,
    secondaryHeaderColor: Colors.grey[600],
    shadowColor: Colors.grey[200],
    backgroundColor: HexColor("#8b7c61"),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey[900],
      ),
      actionsIconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey[900]),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
  );
}
