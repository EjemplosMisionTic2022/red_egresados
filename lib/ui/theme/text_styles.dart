import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static String? get fontFamily => GoogleFonts.openSans().fontFamily;
  //static String? get fontFamily => GoogleFonts.yanoneKaffeesatz().fontFamily;

  // Google font
  static TextStyle get defaultFontStyle => GoogleFonts.openSans();

  // if we need to change a style
  static TextStyle get headline1 => GoogleFonts.openSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get cardTitle => GoogleFonts.openSans(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get cardContent => GoogleFonts.openSans(
        fontSize: 16.0,
      );
  static TextStyle get cardDetails => GoogleFonts.openSans(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      );

  /// The default text style for [Material].
  static TextStyle get appBodyText => GoogleFonts.openSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
      );
}
