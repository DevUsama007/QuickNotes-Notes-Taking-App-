import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app_dio/app/res/status.dart';
import 'package:notes_taking_app_dio/app/utils/notification.dart';

import '../../model/notes_model.dart';
import '../../repository/notes_repository.dart';
import '../../utils/storage_services.dart';

class FetchNotesViewModel extends GetxController {
  final searchController = TextEditingController().obs;
  RxString searchText = ''.obs;
  final notesRepository = NotesRepository();
  final rxRequestStatus = Status.LOADING.obs;
  final notesData = <NotesModel>[].obs;
  RxString showError = "Error Occured".obs;
  RxBool deleting = false.obs;
  RxBool deleteSuccess = false.obs;
  fetchNotes() async {
    print('Fetching');
    try {
      late var user_id;
      user_id = await StorageService.read('user_id');
      setRxRequestStatus(Status.LOADING);
      final notesdata = NotesModel(
        userId: user_id.toString(),
      );

      print(notesdata.toJson());
      notesData.value = await notesRepository.FetchNotes(notesdata);
      print(notesData.value.length);
      setRxRequestStatus(Status.COMPLETED);
    } catch (e) {
      setRxRequestStatus(Status.ERROR);
      showError.value = e.toString();
      print('Error: $e');
    }
  }

  deleteNotes(BuildContext context, String notesId, String coverImage,
      String supportedImage) async {
    try {
      deleting.value = true;
      final notesData = NotesModel(
        id: notesId.toString().trim(),
        coverImage: coverImage.toString().trim(),
        supertiveFile: supportedImage.toString().trim(),
      );
      print(notesData.toJson());
      var response = await notesRepository.deleteNotes(notesData);
      if (response['success'] == true) {
        deleteSuccess.value = true;
        Navigator.pop(context);
        NotificationUtils.customNotification(
            context, 'Deleted', response['message'], true);
        deleting.value = false;
        deleteSuccess.value = true;
        Get.back();
      } else {
        NotificationUtils.customNotification(
            context, 'Failed', response['message'], false);
        deleting.value = false;
      }
    } catch (e) {
      print(e);
      NotificationUtils.customNotification(
          context, 'Failed', e.toString(), true);
      deleting.value = false;
    }
  }

  setRxRequestStatus(Status _value) {
    rxRequestStatus.value = _value;
  }

  Future<void> handleRefresh() async {
    // Simulate network request
    fetchNotes();
    await Future.delayed(Duration(seconds: 1));
    // You would typically call your data refresh here
    // await _controller.fetchData();
  }
}
