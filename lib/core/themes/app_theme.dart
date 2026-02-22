import 'package:evently/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(String lang) => ThemeData(
    fontFamily: lang == 'ar'
        ? GoogleFonts.tajawal().fontFamily
        : GoogleFonts.poppins().fontFamily,
    primaryColor: AppColor.lightModeMainColor,
    scaffoldBackgroundColor: AppColor.lightModeBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.darkModeMainTextColor,
      selectedItemColor: AppColor.lightModeMainColor,
      unselectedItemColor: AppColor.lightModeDisableColor,
    ),
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColor.darkModeMainTextColor,
        ),
        padding: EdgeInsets.all(16),
        backgroundColor: AppColor.lightModeMainColor,
        foregroundColor: AppColor.lightModeInputsColor,
        elevation: 0,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.lightModeMainColor,
      foregroundColor: AppColor.lightModeBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(360),
      ),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      fillColor: AppColor.darkModeMainTextColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColor.darkModeDisableColor.withValues(alpha: 0.7),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColor.darkModeDisableColor.withValues(alpha: 0.7),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColor.darkModeDisableColor.withValues(alpha: 0.7),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColor.lightModeSecTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColor.lightModeSecTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColor.lightModeSecTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColor.lightModeMainTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColor.lightModeMainTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColor.lightModeMainTextColor,
      ),
    ),
  );
  static ThemeData darkTheme(String lang) => ThemeData(
    fontFamily: lang == 'ar'
        ? GoogleFonts.tajawal().fontFamily
        : GoogleFonts.poppins().fontFamily,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    primaryColor: AppColor.darkModeMainColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.darkModeBackgroundColor,
      selectedItemColor: AppColor.darkModeMainColor,
      unselectedItemColor: AppColor.darkModeDisableColor,
    ),
    scaffoldBackgroundColor: AppColor.darkModeBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.darkModeMainColor,
      foregroundColor: AppColor.lightModeBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(360),
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: AppColor.darkModeMainColor.withValues(alpha: 0.1),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColor.darkModeMainColor.withValues(alpha: 0.7),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColor.darkModeMainColor.withValues(alpha: 0.7),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColor.darkModeMainColor.withValues(alpha: 0.7),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColor.darkModeMainTextColor,
        ),
        padding: EdgeInsets.all(16),
        backgroundColor: AppColor.darkModeMainColor,
        foregroundColor: AppColor.lightModeInputsColor,
        elevation: 0,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),

    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColor.darkModeSecTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColor.darkModeSecTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColor.darkModeSecTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColor.darkModeMainTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColor.darkModeMainTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColor.darkModeMainTextColor,
      ),
    ),
  );
}
