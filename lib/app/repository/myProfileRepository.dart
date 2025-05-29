import 'dart:io';

import 'package:dio/dio.dart';
import 'package:notes_taking_app_dio/app/data/network/base_api_services.dart';
import 'package:notes_taking_app_dio/app/data/network/network_api_services.dart';
import 'package:notes_taking_app_dio/app/model/user_model.dart';

import '../data/response/app_exception.dart';
import '../res/app_url.dart';

class Myprofilerepository {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<UserModel> updateProfile(UserModel userData, File? image) async {
    final formdata = FormData.fromMap({
      ...userData.toJson(),
      if (image != null)
        'profile_image': await MultipartFile.fromFile(
          image!.path,
          filename: 'profileImage_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
    });
    print('--- FormData Fields ---');
    formdata.fields.forEach((field) {
      print('${field.key}: ${field.value}');
    });
    print('\n--- FormData Files ---');
    formdata.files.forEach((file) {
      print('${file.key}: ${file.value.filename}');
      print('  Path: ${file.value.filename}');
      print('  ContentType: ${file.value.contentType}');
      print('  Length: ${file.value.length} bytes');
    });
    final response =
        await _apiServices.postApi(formdata, AppUrl.updateProfileApi);
    final responseData = response.data;
    if (responseData['status'] == 'success') {
      return UserModel.fromJson(responseData['user']);
    } else {
      throw DefaultException(responseData['message']);
    }
  }
}
