import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_taking_app_dio/app/custom_widget/custom_textField.dart';
import 'package:notes_taking_app_dio/app/custom_widget/loading_indicator_widget.dart';
import 'package:notes_taking_app_dio/app/res/app_assets.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:notes_taking_app_dio/app/res/app_string.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/res/status.dart';
import 'package:notes_taking_app_dio/app/view_model/auth/registerViewModel.dart';
import '../../custom_widget/custom_btn_widget.dart';
import '../../res/app_text_styles.dart';
import '../../res/routes/route_name.dart';

class RegisterscreenView extends StatefulWidget {
  const RegisterscreenView({super.key});

  @override
  State<RegisterscreenView> createState() => _RegisterscreenViewState();
}

class _RegisterscreenViewState extends State<RegisterscreenView> {
  RegisterControler registerControler = Get.put(RegisterControler());
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
              AppStrings.registerpageTitle,
              style: AppTextStyles.customText(
                  fontSize: 22,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold),
            ),
            Obx(
              () {
                return GestureDetector(
                  onTap: () => registerControler.pickImage(context),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        registerControler.selectedImage.value == null
                            ? AssetImage(AppAssets.imagePlaceholder)
                            : FileImage(registerControler.selectedImage.value!),
                  ).paddingOnly(top: 10, bottom: 10),
                );
              },
            ),
            CustomTextFieldWidget(
                controller: registerControler.nameController,
                hintText: 'Enter Your Name',
                labeltext: 'Name',
                leadingIcon: Icon(
                  Icons.person_2,
                  color: AppColors.iconColor,
                )),
            CustomTextFieldWidget(
                controller: registerControler.lastNameController,
                hintText: 'Enter Your LastName',
                labeltext: 'Last Name',
                leadingIcon: Icon(
                  Icons.person_2,
                  color: AppColors.iconColor,
                )).paddingOnly(top: 10),
            CustomTextFieldWidget(
                controller: registerControler.emailController,
                hintText: 'Enter Your Email',
                labeltext: 'Email',
                leadingIcon: Icon(
                  Icons.email_rounded,
                  color: AppColors.iconColor,
                )).paddingOnly(top: 10),
            CustomTextFieldWidget(
                controller: registerControler.passwordController,
                hintText: 'Enter Your Password',
                labeltext: 'Password',
                leadingIcon: Icon(
                  Icons.password_outlined,
                  color: AppColors.iconColor,
                )).paddingOnly(top: 10),
            Obx(
              () {
                return registerControler.rxRequestStatus.value == Status.LOADING
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
                        btn_text: AppStrings.registerBtnText,
                        isloading: false,
                        onTap: () {
                          registerControler.validateFeilds(context);
                        },
                      ).paddingOnly(bottom: 20, top: 20);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.alreadyAccount,
                  style: AppTextStyles.customText(
                      color: AppColors.secondaryTextColor, fontSize: 12),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteName.loginScreenView);
                  },
                  child: Text(
                    AppStrings.loginButton,
                    style: AppTextStyles.customTextbold12(),
                  ),
                ),
              ],
            )
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 20),
      ),
    );
  }
}
