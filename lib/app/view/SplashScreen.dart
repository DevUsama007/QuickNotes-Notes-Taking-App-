import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_taking_app_dio/app/res/app_assets.dart';
import 'package:notes_taking_app_dio/app/res/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_taking_app_dio/app/view_model/services/SplashScreenServices.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  SplashScreenServices _controler = Get.put(SplashScreenServices());
  @override
  void initState() {
    super.initState();
    _controler.splashDelayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(color: AppColors.backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.appLogo,
              width: 100,
              height: 100,
            ).marginOnly(top: 300),
            Transform.scale(
              scale: 0.1,
              child: LoadingIndicator(
                indicatorType: Indicator.lineScalePulseOutRapid,
                colors: [
                  Colors.purple,
                ],
                // backgroundColor: AppColors.iconColor,
                strokeWidth: 0.7,
              ),
            ).marginOnly(top: 10),
          ],
        ),
      ),
    );
  }
}
