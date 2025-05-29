import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_taking_app_dio/app/custom_widget/cached_network_image_widget.dart';
import 'package:notes_taking_app_dio/app/res/app_assets.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:notes_taking_app_dio/app/res/app_text_styles.dart';
import 'package:notes_taking_app_dio/app/res/app_url.dart';

class NotesViewWidget extends StatelessWidget {
  String imagePath;
  String title;
  String detail;
  Color bgColor;
  NotesViewWidget({
    super.key,
    required this.bgColor,
    required this.title,
    required this.detail,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor.withOpacity(0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width * 0.45,
            height: 130,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomCachedNetworkImage(
                  imageUrl: AppUrl.imagePath + imagePath),
            ),
            // child: Image.asset(fit: BoxFit.cover, AppAssets.demoImge),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                child: Text(
                  title,
                  style: AppTextStyles.customText(
                      fontSize: 14, color: AppColors.textColor),
                ),
              ),
              Container(
                height: 70,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  '$detail'.toString(),
                  style: AppTextStyles.customText(
                      color: AppColors.detailColor.withOpacity(0.4)),
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                ).paddingOnly(left: 5),
              )
            ],
          ).paddingOnly(top: 10, left: 5, right: 5)
        ],
      ),
    );
  }
}
