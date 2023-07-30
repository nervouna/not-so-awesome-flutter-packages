import 'package:dio/dio.dart';

import 'api.dart';

class OpenAiApi extends BaseChatApi {
  final String _apiHost;
  final String _apiKey;
  final String? _organization;

  const OpenAiApi({
    required String apiKey,
    String apiHost = 'https://api.openai.com',
    String? organization,
  })  : _apiHost = apiHost,
        _apiKey = apiKey,
        _organization = organization;
  @override
  String get apiEndpoint => '/v1/chat/completions';

  @override
  String get apiHost => _apiHost;

  @override
  String get apiKey => _apiKey;

  @override
  Map<String, dynamic> get headers {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    if (_organization != null) {
      headers['OpenAI-Organization'] = _organization!;
    }
    return headers;
  }

  @override
  Dio makeApiClient() {
    return Dio(BaseOptions(
      baseUrl: apiHost,
      headers: headers,
    ));
  }

  @override
  Dio makeStreamApiClient() {
    return Dio(BaseOptions(
      baseUrl: apiHost,
      headers: headers,
      responseType: ResponseType.stream,
    ));
  }
}
