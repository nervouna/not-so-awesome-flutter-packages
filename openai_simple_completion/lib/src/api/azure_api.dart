import 'package:dio/dio.dart';

import 'api.dart';

class AzureChatApi extends BaseChatApi {
  final String deploymentId;
  final String apiVersion;
  final String _apiKey;
  final String _apiHost;
  const AzureChatApi({
    required String apiKey,
    required String apiHost,
    required this.deploymentId,
    required this.apiVersion,
  })  : _apiHost = apiHost,
        _apiKey = apiKey;
  @override
  String get apiEndpoint =>
      '/openai/deployments/$deploymentId/chat/completions';

  @override
  String get apiHost => _apiHost;

  @override
  String get apiKey => _apiKey;

  @override
  Map<String, dynamic> get headers => {
        'Content-Type': 'application/json',
        'API-Key': apiKey,
      };

  @override
  Dio makeApiClient() {
    return Dio(BaseOptions(
      baseUrl: _apiHost,
      headers: headers,
      queryParameters: {'api-version': apiVersion},
    ));
  }

  @override
  Dio makeStreamApiClient() {
    return Dio(BaseOptions(
      baseUrl: _apiHost,
      headers: {...headers, 'X-Accel-Buffering': 'no'},
      queryParameters: {'api-version': apiVersion},
      responseType: ResponseType.stream,
    ));
  }
}
