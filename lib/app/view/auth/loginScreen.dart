import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_taking_app_dio/app/custom_widget/custom_btn_widget.dart';
import 'package:notes_taking_app_dio/app/res/app_assets.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:notes_taking_app_dio/app/res/app_string.dart';
import 'package:notes_taking_app_dio/app/res/app_text_styles.dart';
import 'package:notes_taking_app_dio/app/res/routes/route_name.dart';
import 'package:notes_taking_app_dio/app/view/bottom_navigation_bar/bottomNavigationBarScreen.dart';

import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/view_model/auth/loginViewModel.dart';
import '../../custom_widget/custom_textField.dart';
import '../../custom_widget/loading_indicator_widget.dart';
import '../../res/status.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  Loginviewmodel loginControler = Get.put(Loginviewmodel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteName.bottomnavigationbarscreen);
            },
            child: SvgPicture.asset(
              AppAssets.loginImage2,
              width: 220,
              height: 220,
            ).marginOnly(top: 120, bottom: 50),
          ),
          Text(
            AppStrings.welcomnote,
            style: AppTextStyles.customText(
                fontSize: 18,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold),
          ),
          CustomTextFieldWidget(
              controller: loginControler.emailController,
              hintText: AppStrings.loginTextfieldemailhint,
              labeltext: AppStrings.loginTextfieldemaillabel,
              leadingIcon: Icon(
                Icons.email,
                color: AppColors.iconColor,
              )).paddingSymmetric(vertical: 10),
          CustomTextFieldWidget(
              controller: loginControler.passwordController,
              hintText: AppStrings.loginTextfieldpasshint,
              labeltext: AppStrings.loginTextfieldpasslabel,
              leadingIcon: Icon(
                Icons.password_rounded,
                color: AppColors.iconColor,
              )).paddingSymmetric(vertical: 10),
          Obx(
            () {
              return loginControler.rxRequestStatus.value == Status.LOADING
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
                      bottom: 20,
                    )
                  : CustomeButtonWidget(
                      btn_width: Get.width * 0.9,
                      btn_text: AppStrings.loginButton,
                      isloading: false,
                      onTap: () {
                        loginControler.validateFeilds(context);
                      },
                    ).paddingOnly(bottom: 20);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                AppStrings.dontHaveAccount,
                style: AppTextStyles.customText(
                    color: AppColors.secondaryTextColor, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteName.registerScreenView);
                },
                child: Text(
                  AppStrings.registerBtnText,
                  style: AppTextStyles.customTextbold12(),
                ),
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 20)),
    );
  }
}
