import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:notes_taking_app_dio/app/data/network/base_api_services.dart';
import 'package:notes_taking_app_dio/app/data/network/network_api_services.dart';
import 'package:notes_taking_app_dio/app/model/user_model.dart';
import 'package:notes_taking_app_dio/app/res/app_url.dart';

import '../data/response/app_exception.dart';

class LoginRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> loginUser(UserModel user) async {
    try {
      print(user.email);
      print(user.password);
      final formdata = FormData.fromMap({...user.toJson()});
      print('--- FormData Fields ---');
      formdata.fields.forEach((field) {
        print('${field.key}: ${field.value}');
      });
      final response = await _apiServices.postApi(formdata, AppUrl.loginApi);

      final responseData = jsonDecode(response.data);
      // return responseData.data;
      if (responseData['status'] == 'success') {
        return UserModel.fromJson(responseData['user']);
      } else {
        throw DefaultException(responseData['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
