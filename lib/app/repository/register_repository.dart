import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:notes_taking_app_dio/app/data/network/base_api_services.dart';
import 'package:notes_taking_app_dio/app/data/network/network_api_services.dart';
import 'package:notes_taking_app_dio/app/data/response/app_exception.dart';
import 'package:notes_taking_app_dio/app/model/user_model.dart';
import 'package:notes_taking_app_dio/app/res/app_url.dart';

class RegisterRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> RegisterUser(UserModel user, File? profileImage) async {
    try {
      final formdata = FormData.fromMap({
        ...user.toJson(),
        'profile_image': await MultipartFile.fromFile(
          profileImage!.path,
          filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });
      // print('--- FormData Fields ---');
      // formdata.fields.forEach((field) {
      //   print('${field.key}: ${field.value}');
      // });
      // print('\n--- FormData Files ---');
      // formdata.files.forEach((file) {
      //   print('${file.key}: ${file.value.filename}');
      //   print('  Path: ${file.value.filename}');
      //   print('  ContentType: ${file.value.contentType}');
      //   print('  Length: ${file.value.length} bytes');
      // });
      var response = await _apiServices.postApi(formdata, AppUrl.registerApi);
      final responseData = response.data;
      if (responseData['status'] == 'success') {
        return UserModel.fromJson(responseData['user']);
      } else {
        throw DefaultException(responseData['message']);
      }
      // print(response);
      // return (response as List)
      //     .map(
      //       (userJson) => UserModel.fromJson(userJson),
      //     )
      //     .toList();
    } catch (e) {
      print('error');
      rethrow;
    }
  }
}
