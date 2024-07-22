import 'package:dio/dio.dart';
import 'package:mottu_marvel/shared/services/http/interceptors/auth_interceptor.dart';

Dio createDioFactory() {
  final dio = Dio(
    BaseOptions(
      baseUrl: const String.fromEnvironment("BASE_URL"),
      contentType: Headers.jsonContentType,
    ),
  );

  dio.interceptors.add(AuthInterceptor());
  return dio;
}
