import 'package:flutter/material.dart';

enum HLThemes { light, dark }

class HLThemesData {
  static final themesMap = {
    HLThemes.light: _lightTheme,
    HLThemes.dark: _darkTheme,
  };

  static final ThemeData _lightTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,

    // Define the default font family.
    fontFamily: 'poppins',

    // scroll glow color
    // accentColor: Colors.white,
    // accentColorBrightness: Brightness.light,

    // fluid transitions...
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        // TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),

    // // Define the default TextTheme. Use this to specify the default
    // // text styling for headlines, titles, bodies of text, and more.
    // textTheme: TextTheme(
    //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    // ),
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'poppins',
    // fluid transitions...
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}
