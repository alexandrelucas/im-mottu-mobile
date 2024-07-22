import 'package:dio/dio.dart';
import 'package:mottu_marvel/shared/utils/md5_hash.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    const apiKey = String.fromEnvironment("API_PUBLIC_KEY");
    const privateKey = String.fromEnvironment("API_PRIVATE_KEY");

    final hash = textToMd5("$timestamp$privateKey$apiKey");

    final updatedOptions = options.copyWith(queryParameters: {
      "apikey": apiKey,
      "ts": timestamp,
      "hash": hash,
    });
    handler.next(updatedOptions);
  }
}
