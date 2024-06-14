import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Muli',
    appBarTheme: appBarTheme()
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color.fromARGB(255, 41, 41, 41)),
    titleTextStyle: TextStyle(color: Color.fromARGB(255, 41, 41, 41), fontSize: 18),
  );
}