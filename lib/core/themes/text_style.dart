import 'package:evently/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle size20black = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily,
    color: AppColor.lightModeMainTextColor,
  );
  static TextStyle size16black = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.poppins().fontFamily,
    color: AppColor.lightModeSecTextColor,
  );
}
