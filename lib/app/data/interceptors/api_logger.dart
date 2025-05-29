import 'package:dio/dio.dart';

class ApiLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🌐 [${options.method}] ${options.uri}');
    print('📦 Request Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ [${response.statusCode}] ${response.requestOptions.uri}');
    print('📦 Response Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('⛔ [${err.response?.statusCode}] ${err.requestOptions.uri}');
    print('📦 Error: ${err.response?.data}');
    super.onError(err, handler);
  }
}
