import 'package:flutter/material.dart';
import 'package:doc_qa_flutter_app/config/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
    splashColor: Colors.pinkAccent.shade100,
    textTheme: GoogleFonts.lexendTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextColor,
        ),
        displayMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.lightSecondaryTextColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: AppColors.lightSecondaryTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: AppColors.lightSecondaryTextColor,
        ),
        titleMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: AppColors.lightSecondaryTextColor,
        ),
        titleSmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: AppColors.lightSecondaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: AppColors.lightTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: AppColors.lightSecondaryTextColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: AppColors.lightSecondaryTextColor,
        ),
        labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        labelMedium: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        labelSmall: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
    splashColor: Colors.pinkAccent.shade100,
    textTheme: GoogleFonts.victorMonoTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextColor,
        ),
        displayMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.darkSecondaryTextColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextColor,
        ),
        titleMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: AppColors.darkSecondaryTextColor,
        ),
        titleSmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: AppColors.darkSecondaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: AppColors.darkTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: AppColors.darkSecondaryTextColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: AppColors.darkSecondaryTextColor,
        ),
        labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        labelMedium: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        labelSmall: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
      ),
    ),
  );
}
