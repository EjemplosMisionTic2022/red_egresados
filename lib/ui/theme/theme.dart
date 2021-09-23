import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'text_styles.dart';

class MyTheme {
  static ThemeData get ligthTheme {
    return ThemeData(
      primarySwatch: AppColors.createMaterialColor(AppColors.primaryColor),
      colorScheme: AppColors.lightScheme,
      fontFamily: AppTextStyle.fontFamily,
      textTheme: AppTextStyle.textTheme,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        fillColor: Colors.grey.shade300,
      ),
    );
  }

  // on DarkMode the Swatch parameter is not working
  // https://github.com/flutter/flutter/issues/19089
  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: AppColors.createMaterialColor(AppColors.primaryColor),
      colorScheme: AppColors.darkScheme,
      toggleableActiveColor: AppColors.darkScheme.secondary,
      // this can all be copied, waiting for verification
      fontFamily: AppTextStyle.fontFamily,
      textTheme: AppTextStyle.textTheme.copyWith(
        bodyText1: AppTextStyle.bodytext1.copyWith(
          color: Colors.white70,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(),
      // copy from ligthTheme
      inputDecorationTheme: ligthTheme.inputDecorationTheme,
    );
  }
}
