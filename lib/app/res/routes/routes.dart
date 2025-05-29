import 'package:notes_taking_app_dio/app/res/routes/route_name.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/view/SplashScreen.dart';
import 'package:notes_taking_app_dio/app/view/auth/RegisterScreen.dart';
import 'package:notes_taking_app_dio/app/view/bottom_navigation_bar/bottomNavigationBarScreen.dart';
import 'package:notes_taking_app_dio/app/view/notesScreen/notesDetailScreen.dart';

import '../../view/auth/loginScreen.dart';
import '../../view/notesScreen/notesViewScreen.dart';

class ApprRoutes {
  static List<GetPage> appRoutes() {
    return [
      GetPage(
          name: RouteName.splashScreen,
          page: () => Splashscreen(),
          transition: Transition.leftToRight),
      GetPage(
          name: RouteName.notesViewScreen,
          page: () => const NotesViewScreen(),
          transition: Transition.leftToRight),
      GetPage(
          name: RouteName.loginScreenView,
          page: () => const LoginScreenView(),
          transition: Transition.leftToRight),
      GetPage(
          name: RouteName.registerScreenView,
          page: () => const RegisterscreenView(),
          transition: Transition.leftToRight),
      GetPage(
          name: RouteName.bottomnavigationbarscreen,
          page: () => const Bottomnavigationbarscreen(),
          transition: Transition.leftToRight),
      GetPage(
          name: RouteName.notesDetailScreen,
          page: () => NotesDetailScreen(
                id: '',
                title: '',
                detail: '',
                imagePath: '',
                supportedfile: '',
              ),
          transition: Transition.leftToRight),
    ];
  }
}
