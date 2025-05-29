import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:notes_taking_app_dio/app/data/response/apiResponse.dart';

import '../interceptors/api_logger.dart';
import '../response/app_exception.dart';
import '../response/handleDioError.dart';
import 'base_api_services.dart';

class NetworkApiServices implements BaseApiServices {
  final Dio _dio = Dio()..interceptors.add(ApiLogger());

  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await _dio.get(url).timeout(Duration(seconds: 10));
      return Apiresponse.returnResponse(response);
    } on DioException catch (e) {
      HandleDioError.handleDioError(e);
    }
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        onSendProgress: (sent, total) {
          print('${(sent / total * 100).toStringAsFixed(0)}%');
        },
        options: Options(
          contentType: Headers.multipartFormDataContentType,
        ),
      ).timeout(Duration(seconds: 10));
      print("return response ${response}");
      return Apiresponse.returnResponse(response);
    } on DioException catch (e) {
      print('fffffffffffffffffffffff');
      // _handleDioError(e);
      HandleDioError.handleDioError(e);
    }
  }

  // dynamic _returnResponse(Response response) {
  //   switch (response.statusCode) {
  //     case 200:
  //       print(response);
  //       return response;
  //     case 400:
  //       throw InvalidUrl(response.data.toString());
  //     case 401:
  //       throw InternetException(response.data.toString());
  //     // Client Errors
  //     case 429:
  //       throw RateLimitException('Too many requests. Retry later.');
  //     case 404:
  //       throw NotFoundException('Resource not found: ${response.data}');
  //     case 422:
  //       throw ValidationException('Validation failed: ${response.data}');
  //     case 429:
  //       throw RateLimitException('Too many requests. Retry later.');

  //     default:
  //       throw FailedToFetch(
  //         'Error occurred while communication with server with status code : ${response.statusCode}',
  //       );
  //   }
  // }

  // void _handleDioError(DioException e) {
  //   if (e.type == DioExceptionType.connectionTimeout ||
  //       e.type == DioExceptionType.receiveTimeout ||
  //       e.type == DioExceptionType.sendTimeout) {
  //     throw TimeoutException('Timeout Error');
  //   } else if (e.error is SocketException) {
  //     throw InternetException('No Internet Connection');
  //   } else {
  //     throw FailedToFetch(e.response?.data['message'] ?? 'Unknown Error');
  //   }
  // }
}
