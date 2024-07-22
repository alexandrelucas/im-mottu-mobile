class HttpClientException implements Exception {
  final String? message;
  final int statusCode;
  final dynamic data;
  final dynamic response;
  final dynamic error;
  final dynamic type;

  HttpClientException({
    required this.message,
    required this.statusCode,
    required this.data,
    required this.response,
    required this.error,
    required this.type,
  });
}
