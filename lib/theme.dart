import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    dialogBackgroundColor: Color(0xFF121212),
    dividerColor: Colors.grey,
    accentColor: Colors.green,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: Colors.green,
          onPrimary: Colors.black,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))),
    ));
