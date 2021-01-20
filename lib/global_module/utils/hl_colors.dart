import 'package:flutter/material.dart';

class HLColors {
  // While switching modes.
  static LinearGradient lightGradient = LinearGradient(
    colors: [Color(0xFFe3eeff), Color(0xFFf3e7e9)],
  );
  static LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF29323c), Color(0xFF485563)],
  );

  static List<Color> primaryColorsList = [
    Color(0xFF00f2fe),
    Color(0xFF4facfe),
  ];

  static List<Color> secondaryColorsList = [
    Color(0xFFfc6076),
    Color(0xFFff9a44),
  ];

  static Color primaryColor = primaryColorsList[0];
  static Color secondaryColor = secondaryColorsList[1];

  // static Color primaryColor = Color(0xFF5df2d6);
  // static Color secondaryColor = Color(0xFFffdd4b);

  static LinearGradient primaryGradient = LinearGradient(
    colors: primaryColorsList,
  );
  static LinearGradient secondaryGradient = LinearGradient(
    colors: secondaryColorsList,
  );

  //char colors

  static Color primary = Color(0xFFF391A0);
  static Color grey = Color(0xFFe9eaec);
  static Color white = Color(0xFFFFFFFF);
  static Color black = Color(0xFF000000);
  static Color online = Color(0xFF66BB6A);
  static Color blueStory = Colors.blueAccent;
}
