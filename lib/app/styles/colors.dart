import 'package:flutter/material.dart';

class ProjectColors {
  static const Color orange = Color(0xFFEC8164);
  static const Color pink = Color(0xFFF14C63);
  static const Color background = Color(0xFF131824);
  static const Color gray = Color(0xFF232936);
  static const Color lightGray = Color(0xFF4E596F);
  static const Color darkGray = Color(0xFF1F2430);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ProjectColors.orange,
      ProjectColors.pink,
    ],
  );
}
