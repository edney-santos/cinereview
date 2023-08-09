import 'package:flutter/material.dart';

const String fontName = 'Montserrat';

class ProjectText {
  static const TextStyle tittle = TextStyle(
    color: Colors.white,
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );

  static const TextStyle regular = TextStyle(
    color: Colors.white,
    fontFamily: fontName,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bold = TextStyle(
    color: Colors.white,
    fontFamily: fontName,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle boldUnderline = TextStyle(
    color: Colors.white,
    fontFamily: fontName,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
  );

  static const TextStyle label = TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle movieCard = TextStyle(
    color: Colors.white,
    fontFamily: fontName,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
}
