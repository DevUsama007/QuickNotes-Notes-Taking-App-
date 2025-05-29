import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_taking_app_dio/app/custom_widget/custom_btn_widget.dart';
import 'package:notes_taking_app_dio/app/custom_widget/custom_textField.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:notes_taking_app_dio/app/res/app_text_styles.dart';
import 'package:notes_taking_app_dio/app/utils/storage_services.dart';
import 'package:notes_taking_app_dio/app/view/SplashScreen.dart';
import 'package:notes_taking_app_dio/app/view/auth/loginScreen.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/view_model/notesViewModel/addNewNotesViewModel.dart';
import 'package:notes_taking_app_dio/app/view_model/services/SplashScreenServices.dart';
import '../../custom_widget/customAppBar.dart';
import '../../custom_widget/loading_indicator_widget.dart';
import '../../res/status.dart';

class AddNewNotesScreen extends StatefulWidget {
  const AddNewNotesScreen({super.key});

  @override
  State<AddNewNotesScreen> createState() => _AddNewNotesScreenState();
}

class _AddNewNotesScreenState extends State<AddNewNotesScreen> {
  Addnewnotesviewmodel notesController = Get.put(Addnewnotesviewmodel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
            icon: Icons.logout,
            ontap: () {
              showModalBottomSheet(
                elevation: 0.2,
                context: context,
                builder: (context) {
                  return Container(
                    height: 200,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Are You Realy Want to logout',
                          style: AppTextStyles.customText(fontSize: 20),
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomeButtonWidget(
                              btn_width: Get.width * 0.4,
                              btn_text: 'Cancel',
                              isloading: false,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            CustomeButtonWidget(
                              btn_width: Get.width * 0.4,
                              btn_text: 'Logout',
                              isloading: false,
                              onTap: () {
                                StorageService.remove('user_id');
                                Get.offAll(Splashscreen());
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ).marginOnly(left: 20, top: 40, right: 20);
                },
              );
            },
            actions: [
              GestureDetector(
                onTap: () {
                  // StorageService.remove('user_id');
                  notesController.resetTheNotes();
                },
                child: Icon(
                  Icons.refresh_sharp,
                  color: Colors.white,
                ).paddingOnly(right: 20),
              )
            ],
            backgroundColor: AppColors.iconColor,
            title: 'Add New Notes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                return InkWell(
                  onTap: () {
                    notesController.pickImage(context);
                  },
                  child: Container(
                          width: Get.width * 0.9,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(color: AppColors.iconColor)),
                          child: notesController.selectedImage.value == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      color: AppColors.iconColor,
                                    ),
                                    Text(
                                      'NO Cover Image Selected',
                                      style: AppTextStyles.customText(
                                          fontSize: 12,
                                          color: AppColors.secondaryTextColor),
                                    ),
                                  ],
                                )
                              : Image.file(
                                  fit: BoxFit.fill,
                                  notesController.selectedImage.value!))
                      .paddingOnly(bottom: 10),
                );
              },
            ),
            CustomTextFieldWidget(
                controller: notesController.titleController,
                hintText: "Enter the Title",
                labeltext: "Title",
                leadingIcon: Icon(
                  Icons.title,
                  color: AppColors.iconColor,
                )).paddingOnly(bottom: 10),
            CustomTextFieldWidget(
                maxlines: 8,
                controller: notesController.detailController,
                hintText: "Enter the Detail",
                labeltext: "Detail",
                leadingIcon: Icon(
                  Icons.details_rounded,
                  color: AppColors.iconColor,
                )).paddingOnly(bottom: 10),
            Obx(
              () {
                return InkWell(
                  onTap: () {
                    notesController.pickSupportedFile(context);
                  },
                  child: Container(
                    width: Get.width * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: AppColors.iconColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          // width: Get.width * 0.6,
                          child: Text(
                            notesController.selectedFile.value == null
                                ? 'No Supported File Selected'
                                : notesController.selectedFile.value!.name
                                    .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.customText(
                                fontSize: 12,
                                color: AppColors.secondaryTextColor),
                          ),
                        ),
                        Icon(
                          Icons.file_upload,
                          color: AppColors.iconColor,
                        )
                      ],
                    ).paddingSymmetric(horizontal: 20),
                  ),
                );
              },
            ).paddingOnly(bottom: 20),
            Obx(
              () {
                return notesController.rxRequestStatus.value == Status.LOADING
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
                      )
                    : CustomeButtonWidget(
                        btn_width: Get.width * 0.9,
                        btn_text: 'Upload',
                        isloading: false,
                        onTap: () {
                          notesController.validateFields(context);
                        },
                      );
              },
            )
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
