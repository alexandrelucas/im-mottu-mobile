import 'package:dio/dio.dart';
import 'package:mottu_marvel/shared/exceptions/http_client_exception.dart';

import 'http_client_service.dart';

class DioHttpClientServiceImpl implements HttpClientService {
  final Dio dio;

  DioHttpClientServiceImpl(
    this.dio,
  );

  @override
  Future get(String url, {Map<String, dynamic>? headers}) async {
    try {
      return await dio.get(
        url,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw HttpClientException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
        data: e.response?.data,
        response: e.response,
        error: e.error,
        type: e.type,
      );
    }
  }

  @override
  Future post(String url, {data, Map<String, dynamic>? headers}) async {
    try {
      return await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw HttpClientException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
        data: e.response?.data,
        response: e.response,
        error: e.error,
        type: e.type,
      );
    }
  }

  @override
  Future put(String url, {data, Map<String, dynamic>? headers}) async {
    try {
      return await dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw HttpClientException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
        data: e.response?.data,
        response: e.response,
        error: e.error,
        type: e.type,
      );
    }
  }

  @override
  Future delete(String url, {Map<String, dynamic>? headers}) async {
    try {
      return await dio.delete(
        url,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw HttpClientException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
        data: e.response?.data,
        response: e.response,
        error: e.error,
        type: e.type,
      );
    }
  }
}
