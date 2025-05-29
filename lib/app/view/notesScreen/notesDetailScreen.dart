import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_taking_app_dio/app/custom_widget/custom_btn_widget.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:notes_taking_app_dio/app/res/app_text_styles.dart';
import 'package:notes_taking_app_dio/app/utils/notification.dart';
import 'package:notes_taking_app_dio/app/view_model/notesViewModel/download_file_view_model.dart';
import 'package:notes_taking_app_dio/app/view_model/notesViewModel/fetch_notes_view_model.dart';

import '../../custom_widget/cached_network_image_widget.dart';
import '../../custom_widget/loading_indicator_widget.dart';
import '../../res/app_url.dart';
import '../../res/status.dart';

class NotesDetailScreen extends StatefulWidget {
  String id;
  String title;
  String detail;
  String imagePath;
  String supportedfile;

  NotesDetailScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.detail,
      required this.imagePath,
      required this.supportedfile});

  @override
  State<NotesDetailScreen> createState() => _NotesDetailScreenState();
}

class _NotesDetailScreenState extends State<NotesDetailScreen> {
  DownloadController _downloadController = Get.put(DownloadController());
  FetchNotesViewModel _notescontroller =
      Get.put(FetchNotesViewModel(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 250,
                width: Get.width,
                decoration: BoxDecoration(),
                child: CustomCachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: AppUrl.imagePath + widget.imagePath)),
            Container(
              width: Get.width,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.customText(
                          color: AppColors.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.detail,
                      textAlign: TextAlign.justify,
                      style: AppTextStyles.customText(
                          color: AppColors.detailColor.withOpacity(0.8)),
                    ).paddingOnly(top: 10, bottom: 10, left: 15),
                  ],
                ).paddingOnly(left: 15, right: 15, top: 20, bottom: 10),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Obx(
              () {
                return InkWell(
                  onTap: widget.supportedfile == 'none'
                      ? null
                      : _downloadController.isDownloading.value
                          ? null
                          : () {
                              print(
                                  "${AppUrl.imagePath}${widget.supportedfile}");
                              _downloadController.downloadFile(
                                  '${AppUrl.imagePath}${widget.supportedfile}',
                                  "QuickNotes_${widget.title.toString().replaceAll(" ", "_").substring(0, 12)}${widget.supportedfile}",
                                  'QuickNotes');
                            },
                  child: Card(
                    child: _downloadController.isDownloading.value &&
                            widget.supportedfile != 'none'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Downloading: ${_downloadController.downloadProgress.value.toString()}%',
                                style: AppTextStyles.customText(),
                              ),
                            ],
                          ).paddingOnly(top: 10, bottom: 10)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.supportedfile == 'none'
                                  ? Text(
                                      ' Supported File Not Found',
                                      style: AppTextStyles.customText(
                                          color: AppColors.secondaryTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  : Text(
                                      'Download Supported File',
                                      style: AppTextStyles.customText(
                                          color: AppColors.secondaryTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                              widget.supportedfile == 'none'
                                  ? Container()
                                  : Icon(
                                      Icons.download,
                                      color: AppColors.iconColor,
                                    )
                            ],
                          ).marginOnly(
                            top: 10, bottom: 10, left: 30, right: 30),
                  ),
                );
              },
            ),
            Obx(
              () {
                return _downloadController.downloadComplete.value
                    ? CustomeButtonWidget(
                        btn_width: Get.width * 0.9,
                        btn_text: 'Download Complete Open File',
                        isloading: false,
                        onTap: () {
                          _downloadController.openDownloadedFile();
                        },
                      ).paddingOnly(top: 20)
                    : Container();
              },
            ),
            Obx(
              () {
                return _notescontroller.deleting.value
                    ? Container(
                        width: Get.width * 0.9,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(5)),
                        child: LoadingIndicatorWidget(
                            height: 40,
                            strokeWidth: 1,
                            indicator: Indicator.ballPulse,
                            indicatorColor: Colors.white),
                      ).paddingOnly(
                        top: 20,
                        bottom: 20,
                      )
                    : CustomeButtonWidget(
                        btn_width: Get.width * 0.9,
                        btn_text: 'Delete Notes',
                        isloading: false,
                        onTap: () {
                          _notescontroller.deleteNotes(context, widget.id,
                              widget.imagePath, widget.supportedfile);
                        },
                      ).paddingOnly(top: 10, bottom: 40);
              },
            )
          ],
        ),
      ),
    );
  }
}
