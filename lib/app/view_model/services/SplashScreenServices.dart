import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/res/routes/route_name.dart';
import 'package:notes_taking_app_dio/app/utils/storage_services.dart';

class SplashScreenServices extends GetxController {
  late var user_id;
  splashDelayer() {
    print('object');
    Future.delayed(Duration(seconds: 3), () async {
      user_id = await StorageService.read('user_id');
      print(user_id);
      if (user_id == null || user_id == '') {
        Get.offNamed(RouteName.loginScreenView);
      } else {
        Get.offNamed(RouteName.bottomnavigationbarscreen);
      }
    });
  }
}
