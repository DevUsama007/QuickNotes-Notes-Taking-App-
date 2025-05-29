import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/model/user_model.dart';
import 'package:notes_taking_app_dio/app/repository/register_repository.dart';
import 'package:notes_taking_app_dio/app/res/routes/route_name.dart';
import 'package:notes_taking_app_dio/app/utils/notification.dart';
import 'package:notes_taking_app_dio/app/utils/storage_services.dart';

import '../../res/status.dart';
import '../../utils/image_picker.dart';

class RegisterControler extends GetxController {
  final RegisterRepository _registerRepository = RegisterRepository();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final rxRequestStatus = Status.COMPLETED.obs;
  final UserModel userde = UserModel();
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
        emailController.value.text.isEmpty ||
        passwordController.value.text.isEmpty) {
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
    else if (selectedImage.value == null) {
      setRxRequestStatus(Status.COMPLETED);
      NotificationUtils.customNotification(
          context, 'Error Occur', 'Please Select the Profile Image', false);
    } else {
      _registerUser(context);
    }
  }

  _registerUser(BuildContext context) async {
    final user = UserModel(
      name: nameController.value.text.trim(),
      lastname: lastNameController.value.text.trim(),
      email: emailController.value.text.trim(),
      password: passwordController.value.text.trim(),
    );
    print(user.toJson());

    try {
      var registerUser =
          await _registerRepository.RegisterUser(user, selectedImage.value);

      print("Username from raw response: ${registerUser.name}");
      storeUserData(
          registerUser.id.toString(),
          registerUser.name.toString(),
          registerUser.lastname.toString(),
          registerUser.email.toString(),
          registerUser.profileImage.toString());

      setRxRequestStatus(Status.COMPLETED);
      Get.offNamed(RouteName.bottomnavigationbarscreen);
    } catch (e) {
      setRxRequestStatus(Status.COMPLETED);
      if (e.toString() == 'Error Occured Email already registered') {
        NotificationUtils.customNotification(
            context, 'User Found', 'Email Already Registered', false);
      } else {
        NotificationUtils.customNotification(
            context, 'Error', e.toString(), false);
      }
      print(e);
    }
  }

  storeUserData(String id, String name, String lastname, String email,
      String profileImage) {
    StorageService.save('user_id', id);
    StorageService.save('name', name);
    StorageService.save('lastname', lastname);
    StorageService.save('profile_image', profileImage);
    StorageService.save('email', email);
  }

  setRxRequestStatus(Status _value) {
    rxRequestStatus.value = _value;
  }
}
