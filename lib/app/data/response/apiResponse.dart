import 'dart:convert';

import 'package:dio/dio.dart';

import 'app_exception.dart';

class Apiresponse {
  static dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw InvalidUrl(response.data.toString());
      case 401:
        throw InternetException(response.data.toString());
      // Client Errors
      case 429:
        throw RateLimitException('Too many requests. Retry later.');
      case 404:
        throw NotFoundException('Resource not found: ${response.data}');
      case 422:
        throw ValidationException('Validation failed: ${response.data}');
      case 429:
        throw RateLimitException('Too many requests. Retry later.');

      default:
        throw FailedToFetch(
          'Error occurred while communication with server with status code : ${response.statusCode}',
        );
    }
  }
}
