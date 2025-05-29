import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:notes_taking_app_dio/app/res/app_text_styles.dart';

class NotificationUtils {
  static customNotification(
      BuildContext context, String title, String message, bool success) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
          color: success ? AppColors.iconColor : Color(0xFFEF5350),
          title: title.toString(),
          message: message.toString(),
          titleTextStyle: AppTextStyles.customText(fontSize: 20),
          messageTextStyle: AppTextStyles.customText(fontSize: 16),

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants

          contentType: success ? ContentType.success : ContentType.failure),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
