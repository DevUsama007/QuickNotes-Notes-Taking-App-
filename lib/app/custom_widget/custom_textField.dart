import 'package:flutter/material.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';

import '../res/app_text_styles.dart';

class CustomTextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String labeltext;
  Icon leadingIcon;
  int maxlines;
  final VoidCallback? onchange;
  CustomTextFieldWidget(
      {super.key,
      this.onchange,
      this.maxlines = 1,
      required this.controller,
      required this.hintText,
      required this.labeltext,
      required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTextStyles.customText(color: AppColors.textColor),
      cursorColor: AppColors.textColor,
      maxLines: maxlines,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: leadingIcon,
        fillColor: AppColors.backgroundColor,
        labelText: labeltext,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.secondaryTextColor),
        labelStyle: AppTextStyles.customText(
            color: AppColors.textColor.withOpacity(0.5), fontSize: 12),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors
                .textColor, // Focused border color (e.g., your purple accent)
            width: 1.5, // Thicker border when selected
          ),
          borderRadius: BorderRadius.circular(5), // Match your design
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors
                .textColor, // Focused border color (e.g., your purple accent)
            width: 1.5, // Thicker border when selected
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        // Optional: Add the same borderRadius to the base `border` for consistency
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onChanged: (_) {
        // Only call the callback if it's provided
        onchange?.call();
      },
    );
  }
}
