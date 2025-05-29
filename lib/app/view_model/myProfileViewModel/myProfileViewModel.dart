import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/model/user_model.dart';
import 'package:notes_taking_app_dio/app/repository/myProfileRepository.dart';
import 'package:notes_taking_app_dio/app/utils/notification.dart';
import 'package:notes_taking_app_dio/app/view_model/auth/loginViewModel.dart';
import '../../res/status.dart';
import '../../utils/image_picker.dart';
import '../../utils/storage_services.dart';

class MyProfileController extends GetxController {
  Loginviewmodel _authController = Get.put(Loginviewmodel());
  Myprofilerepository _myprofilerepository = Myprofilerepository();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxString profileImage = ''.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  Future<void> pickImage(BuildContext context) async {
    try {
      final image = await ImagePickerUtils.pickImage();
      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      NotificationUtils.customNotification(
          context, 'Failed', e.toString(), false);
    }
  }

  validateFeilds(BuildContext context) {
    setRxRequestStatus(Status.LOADING);
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.value.text.trim());
    bool validPassword =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(passwordController.value.text.trim());

    if (nameController.value.text.isEmpty ||
        lastNameController.value.text.isEmpty ||
        emailController.value.text.isEmpty) {
      setRxRequestStatus(Status.COMPLETED);
      NotificationUtils.customNotification(
          context, 'Field Error', 'Please Check the Fields', false);
    }
    // else if (!emailValid) {
    //   NotificationUtils.customNotification(
    //       context, 'Invalid Email', 'Please Enter the valid email', false);
    // } else if (!validPassword) {
    //   NotificationUtils.customNotification(context, 'Invalid password',
    //       'Please Enter the valid password', false);
    // }
    else {
      _updateProile(context);
    }
  }

  _updateProile(BuildContext context) async {
    try {
      setRxRequestStatus(Status.LOADING);
      late var user_id;
      user_id = await StorageService.read('user_id');
      final userData = UserModel(
        id: user_id.toString(),
        name: nameController.value.text,
        lastname: lastNameController.value.text,
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      print(userData.toJson());
      var response = await _myprofilerepository.updateProfile(
          userData, selectedImage.value);
      _authController.storeUserData(
          response.id.toString(),
          response.name.toString(),
          response.lastname.toString(),
          response.email.toString(),
          response.profileImage.toString());
      getTheUserData();
      NotificationUtils.customNotification(
          context, 'Success', 'Profile Updated', true);
      print(response.name);
      passwordController.clear();

      setRxRequestStatus(Status.COMPLETED);
    } catch (e) {
      setRxRequestStatus(Status.COMPLETED);
      NotificationUtils.customNotification(
          context, "Error", e.toString(), false);
    }
  }

  getTheUserData() async {
    nameController.text = await StorageService.read('name');
    lastNameController.text = await StorageService.read('lastname');
    emailController.text = await StorageService.read('email');
    profileImage.value = await StorageService.read('profile_image') ?? "";
  }

  setRxRequestStatus(Status _value) {
    rxRequestStatus.value = _value;
  }
}
