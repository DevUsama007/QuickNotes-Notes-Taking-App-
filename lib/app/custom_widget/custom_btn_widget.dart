import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';

import '../res/app_text_styles.dart';

class CustomeButtonWidget extends StatefulWidget {
  bool isloading;
  VoidCallback onTap;
  String btn_text;
  double btn_width;
  CustomeButtonWidget(
      {super.key,
      required this.btn_width,
      required this.btn_text,
      required this.isloading,
      required this.onTap});

  @override
  State<CustomeButtonWidget> createState() => _CustomeButtonWidgetState();
}

class _CustomeButtonWidgetState extends State<CustomeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.btn_width,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.iconColor,
        ),
        child: widget.isloading
            ? Center(
                child: Container(
                  width: 30,
                  height: 30,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4.0,
                  ),
                ),
              )
            : Center(
                child: Text(
                widget.btn_text,
                style: AppTextStyles.customText(
                    fontSize: 14, color: AppColors.backgroundColor),
              )),
      ),
    );
  }
}
