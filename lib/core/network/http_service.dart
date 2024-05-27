import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/config/constants/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_error_interceptor.dart';

final httpServiceProvider = Provider.autoDispose<Dio>(
  (ref) => HttpService(Dio()).dio,
);

class HttpService {
  final Dio _dio;
  // final  userSharedPrefsProvider
  // final state = ref.watch(userSharedPrefsProvider);


  Dio get dio => _dio;

  HttpService(this._dio) {
    _initialize();
  }

  Future<void> _initialize() async {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }
}
