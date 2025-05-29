import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:notes_taking_app_dio/app/model/notes_model.dart';
import 'package:notes_taking_app_dio/app/repository/notes_repository.dart';
import 'package:notes_taking_app_dio/app/utils/file_picker.dart';

import '../../res/status.dart';
import '../../utils/image_picker.dart';
import '../../utils/notification.dart';
import '../../utils/storage_services.dart';

class Addnewnotesviewmodel extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final _notesRepository = NotesRepository();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);
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

  Future<void> pickSupportedFile(BuildContext context) async {
    try {
      final file = await FilePickerUtils.pickFile();
      if (file != null) {
        selectedFile.value = file;
      }
    } catch (e) {
      NotificationUtils.customNotification(
          context, 'Failed', e.toString(), false);
    }
  }

  validateFields(BuildContext context) {
    setRxRequestStatus(Status.LOADING);
    if (titleController.value.text.isEmpty ||
        detailController.value.text.isEmpty) {
      setRxRequestStatus(Status.COMPLETED);
      NotificationUtils.customNotification(
          context, 'Field Error', 'Please , Check the Fields', false);
    } else if (selectedImage.value == null) {
      setRxRequestStatus(Status.COMPLETED);
      NotificationUtils.customNotification(
          context, 'Error Occur', 'Please Select the cover image', false);
    } else {
      uploadNotes(context);
    }
  }

  uploadNotes(BuildContext context) async {
    try {
      setRxRequestStatus(Status.LOADING);
      late var user_id;
      user_id = await StorageService.read('user_id');
      final notesData = NotesModel(
        userId: user_id.toString(),
        notesTitle: titleController.value.text,
        notesDetail: detailController.value.text,
      );
      var response = await _notesRepository.uploadNotes(
          notesData, selectedImage.value, selectedFile.value);
      resetTheNotes();
      print('her is the response of the data ${response}');
      NotificationUtils.customNotification(
          context, "Success", "Notes Uploaded Successfuly", true);

      setRxRequestStatus(Status.COMPLETED);
    } catch (e) {
      setRxRequestStatus(Status.COMPLETED);
      NotificationUtils.customNotification(
          context, "error", e.toString(), false);
    }
  }

  resetTheNotes() {
    titleController.clear();
    detailController.clear();
    selectedFile.value = null;
    selectedImage.value = null;
  }

  setRxRequestStatus(Status _value) {
    rxRequestStatus.value = _value;
  }
}
