import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/error.dart';
import '../model/models.dart';
import '../model/request_models.dart';

abstract class ChatApi {
  const ChatApi();
  @protected
  String get apiEndpoint;
  String get apiHost;
  String get apiKey;
  @protected
  Map<String, dynamic> get headers;
  Future<String> getResponseContent({required ChatRequest request});
  Future<Stream<String>> getResponseContentStream(
      {required ChatRequest request});
  @protected
  Dio makeApiClient();
  @protected
  Dio makeStreamApiClient();
}

abstract class BaseChatApi implements ChatApi {
  const BaseChatApi();

  @override
  Future<String> getResponseContent({required ChatRequest request}) async {
    final client = makeApiClient();
    final requestJson = request.toJson();
    try {
      final response = await client.post(
        apiEndpoint,
        data: jsonEncode(requestJson),
      );
      return response.data['choices'][0]['message']['content'];
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        final openAiError = await handleOpenAiError(error);
        throw openAiError;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Stream<String>> getResponseContentStream(
      {required ChatRequest request}) async {
    assert(request.stream == true);
    final client = makeStreamApiClient();
    final requestJson = request.toJson();
    try {
      final result = await client.post<ResponseBody>(
        apiEndpoint,
        data: jsonEncode(requestJson),
      );
      return result.data!.stream
          .transform<List<int>>(unit8Transformer())
          .transform<String>(const Utf8Decoder())
          .transform<String>(const LineSplitter())
          .transform(messageContentTransformer());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        final openAiError = await handleOpenAiError(error);
        throw openAiError;
      } else {
        rethrow;
      }
    }
  }

  Future<OpenAiError> handleOpenAiStreamError(DioException error) async {
    ResponseBody data = error.response!.data;
    final errorJsonList = await data.stream
        .transform(unit8Transformer())
        .transform(const Utf8Decoder())
        .toList();
    final errorJson = errorJsonList.join();
    final decodedJson = jsonDecode(errorJson);
    return OpenAiError.fromJson(decodedJson['error']);
  }

  Future<OpenAiError> handleOpenAiError(DioException error) async {
    final errorJson = error.response!.data;
    return OpenAiError.fromJson(errorJson['error']);
  }
}

StreamTransformer<Uint8List, List<int>> unit8Transformer() =>
    StreamTransformer.fromHandlers(
      handleData: (Uint8List data, EventSink<List<int>> sink) =>
          sink.add(data.toList()),
    );

StreamTransformer<String, String> messageContentTransformer() =>
    StreamTransformer.fromHandlers(
      handleData: (String data, EventSink<String> sink) {
        if (data.isEmpty) return;
        data = data.substring(5);
        if (data.trim().toLowerCase() == '[done]') return;
        final json = jsonDecode(data);
        final delta = json['choices'][0]['delta'] as Map;
        if (!delta.containsKey('content')) return;
        final content = delta['content'] as String;
        sink.add(content);
      },
    );
