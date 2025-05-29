import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/model/user_model.dart';
import 'package:notes_taking_app_dio/app/repository/login_repository.dart';
import 'package:notes_taking_app_dio/app/res/routes/route_name.dart';

import '../../res/status.dart';
import '../../utils/image_picker.dart';
import '../../utils/notification.dart';
import '../../utils/storage_services.dart';

class Loginviewmodel extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  LoginRepository _loginRepository = LoginRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final rxRequestStatus = Status.COMPLETED.obs;
  validateFeilds(BuildContext context) {
    setRxRequestStatus(Status.LOADING);
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.value.text.trim());
    bool validPassword =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(passwordController.value.text.trim());

    if (emailController.value.text.isEmpty ||
        passwordController.value.text.isEmpty) {
      NotificationUtils.customNotification(
          context, 'Field Error', 'Please Check the Fields', false);
      setRxRequestStatus(Status.COMPLETED);
    }
    // else if (!emailValid) {
    //   NotificationUtils.customNotification(
    //       context, 'Invalid Email', 'Please Enter the valid email', false);
    // } else if (!validPassword) {
    //   NotificationUtils.customNotification(context, 'Invalid password',
    //       'Please Enter the valid password', false);
    // }
    else {
      _loginUser(context);
    }
  }

  Future _loginUser(BuildContext context) async {
    try {
      final user = UserModel(
        email: emailController.value.text.trim(),
        password: passwordController.value.text.trim(),
      );
      var userdata = await _loginRepository.loginUser(user);
      storeUserData(
          userdata.id.toString(),
          userdata.name.toString(),
          userdata.lastname.toString(),
          userdata.email.toString(),
          userdata.profileImage.toString());
      setRxRequestStatus(Status.COMPLETED);
      Get.offNamed(RouteName.bottomnavigationbarscreen);
    } catch (e) {
      if (e.toString() == 'Error Occured User Not Found') {
        setRxRequestStatus(Status.COMPLETED);
        NotificationUtils.customNotification(
            context, 'Not Found', 'User Not Found', false);
      } else {
        setRxRequestStatus(Status.COMPLETED);
        // throw e;
        NotificationUtils.customNotification(
            context, 'Error Occured', e.toString(), false);
      }
    }
  }

  setRxRequestStatus(Status _value) {
    rxRequestStatus.value = _value;
  }

  storeUserData(
      String id, String name, String lastname, String email, String image) {
    StorageService.save('user_id', id);
    StorageService.save('name', name);
    StorageService.save('lastname', lastname);
    StorageService.save('email', email);
    StorageService.save('profile_image', image.toString());
  }
}
