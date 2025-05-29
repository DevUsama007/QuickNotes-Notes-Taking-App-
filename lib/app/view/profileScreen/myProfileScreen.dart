import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_taking_app_dio/app/custom_widget/cached_network_image_widget.dart';
import 'package:notes_taking_app_dio/app/res/app_assets.dart';
import 'package:notes_taking_app_dio/app/res/app_url.dart';
import 'package:notes_taking_app_dio/app/utils/storage_services.dart';
import 'package:notes_taking_app_dio/app/view_model/myProfileViewModel/myProfileViewModel.dart';

import '../../custom_widget/custom_btn_widget.dart';
import '../../custom_widget/custom_textField.dart';
import '../../custom_widget/loading_indicator_widget.dart';
import '../../res/app_colors.dart';
import '../../res/app_string.dart';
import '../../res/app_text_styles.dart';
import '../../res/routes/route_name.dart';
import 'package:get/get.dart';

import '../../res/status.dart';

class Myprofilescreen extends StatefulWidget {
  const Myprofilescreen({super.key});

  @override
  State<Myprofilescreen> createState() => _MyprofilescreenState();
}

class _MyprofilescreenState extends State<Myprofilescreen> {
  MyProfileController myprofileController = Get.put(MyProfileController());
  @override
  @override
  void initState() {
    super.initState();
    myprofileController.getTheUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              AppStrings.myPorfile,
              style: AppTextStyles.customText(
                  fontSize: 22,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold),
            ),

            // CustomCachedNetworkImage(
            //   imageUrl:
            //       AppUrl.imagePath + myprofileController.profileImage.value,
            // ),
            Obx(
              () {
                return GestureDetector(
                  onTap: () {
                    myprofileController.pickImage(context);
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(AppAssets.imagePlaceholder),
                    foregroundImage: myprofileController.selectedImage.value ==
                            null
                        ? myprofileController.profileImage.value == ""
                            ? AssetImage(AppAssets.imagePlaceholder)
                            : CachedNetworkImageProvider(
                                AppUrl.imagePath +
                                    myprofileController.profileImage.toString(),
                                // AppUrl.imagePath +
                                //   myprofileController.profileImage.toString()
                              )
                        : FileImage(File(
                            myprofileController.selectedImage.value!.path)),
                  ).paddingOnly(top: 10, bottom: 10),
                );
              },
            ),
            CustomTextFieldWidget(
                controller: myprofileController.nameController,
                hintText: 'Enter Your Name',
                labeltext: 'Name',
                leadingIcon: Icon(
                  Icons.person_2,
                  color: AppColors.iconColor,
                )),
            CustomTextFieldWidget(
                controller: myprofileController.lastNameController,
                hintText: 'Enter Your LastName',
                labeltext: 'Last Name',
                leadingIcon: Icon(
                  Icons.person_2,
                  color: AppColors.iconColor,
                )).paddingOnly(top: 10),
            CustomTextFieldWidget(
                controller: myprofileController.emailController,
                hintText: 'Enter Your Email',
                labeltext: 'Email',
                leadingIcon: Icon(
                  Icons.email_rounded,
                  color: AppColors.iconColor,
                )).paddingOnly(top: 10),
            CustomTextFieldWidget(
                controller: myprofileController.passwordController,
                hintText: 'Enter Your Password',
                labeltext: 'Password',
                leadingIcon: Icon(
                  Icons.password_outlined,
                  color: AppColors.iconColor,
                )).paddingOnly(top: 10),
            Obx(
              () {
                return myprofileController.rxRequestStatus.value ==
                        Status.LOADING
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
                      ).paddingOnly(bottom: 20, top: 20)
                    : CustomeButtonWidget(
                        btn_width: Get.width * 0.9,
                        btn_text: AppStrings.updateBtnText,
                        isloading: false,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          myprofileController.validateFeilds(context);
                        },
                      ).paddingOnly(bottom: 20, top: 20);
              },
            )
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 20),
      ),
    );
    ;
  }
}
