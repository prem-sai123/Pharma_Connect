import 'package:flutter/material.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';

abstract class AppStyles {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFF5F4F4),
    primaryColor: AppColors.tealGreen,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 8,
      scrolledUnderElevation: 8,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
    ),
  );
}
