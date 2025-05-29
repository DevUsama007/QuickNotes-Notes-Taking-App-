import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:notes_taking_app_dio/app/data/response/app_exception.dart';

class HandleDioError {
  static void handleDioError(DioException e) {
    print(e);
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw TimeoutException('Timeout Error');
    } else if (e.error is SocketException) {
      throw InternetException('No Internet Connection');
    } else {
      print(e.response?.data['message'] ?? 'Unknown Error');
      throw FailedToFetch(e.response?.data['message'] ?? 'Unknown Error');
    }
  }
}
