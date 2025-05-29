import 'package:flutter/material.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';

import 'app_fonts.dart';

abstract class AppTextStyles {
  AppTextStyles._();
  static TextStyle customText({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double fontSize = 12,
    double? height,
  }) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        fontFamily: AppFonts.poetsenOneRegular);
  }

  static TextStyle customTextbold12() {
    return TextStyle(
        color: AppColors.textColor,
        fontFamily: AppFonts.poetsenOneRegular,
        fontSize: 16,
        fontWeight: FontWeight.bold);
  }

  static TextStyle customTextGrey12() {
    return TextStyle(
        color: AppColors.textColor,
        fontFamily: AppFonts.poetsenOneRegular,
        fontSize: 14,
        fontWeight: FontWeight.w500);
  }

  static TextStyle customTextGrey10() {
    return TextStyle(
      color: AppColors.textColor,
      fontFamily: AppFonts.poetsenOneRegular,
      fontSize: 10,
    );
  }
}
