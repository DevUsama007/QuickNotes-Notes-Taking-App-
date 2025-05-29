import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/res/routes/routes.dart';
import 'package:notes_taking_app_dio/app/view/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      getPages: ApprRoutes.appRoutes(),
      home: Splashscreen(),
    );
  }
}
