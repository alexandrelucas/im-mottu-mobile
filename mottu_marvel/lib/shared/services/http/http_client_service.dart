abstract interface class HttpClientService {
  Future get(String url,
      {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters});
  Future post(String url, {dynamic data, Map<String, dynamic>? headers});
  Future put(String url, {dynamic data, Map<String, dynamic>? headers});
  Future delete(String url, {Map<String, dynamic>? headers});
}
