import 'gpt_model.dart';
import 'message_model.dart';

class ChatRequest {
  final GptModel model;
  final List<Message> messages;
  final double? temperature;
  final double? topP;
  final int? n;
  final bool stream;
  final String? stop;
  final int? maxTokens;
  final double? presencePenalty;
  final double? frequencyPenalty;
  final String? user;

  const ChatRequest({
    required this.model,
    required this.messages,
    this.temperature,
    this.topP,
    this.n,
    this.stream = false,
    this.stop,
    this.maxTokens,
    this.presencePenalty,
    this.frequencyPenalty,
    this.user,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'model': model.name,
      'messages': messages.map((e) => e.toJson()).toList(),
      'stream': stream,
    };
    if (temperature != null) {
      json['temperature'] = temperature;
    }
    if (topP != null) {
      json['top_p'] = topP;
    }
    if (n != null) {
      json['n'] = n;
    }
    if (stop != null) {
      json['stop'] = stop;
    }
    if (maxTokens != null) {
      json['max_tokens'] = maxTokens;
    }
    if (presencePenalty != null) {
      json['presence_penalty'] = presencePenalty;
    }
    if (frequencyPenalty != null) {
      json['frequency_penalty'] = frequencyPenalty;
    }
    if (user != null) {
      json['user'] = user;
    }
    return json;
  }
}
