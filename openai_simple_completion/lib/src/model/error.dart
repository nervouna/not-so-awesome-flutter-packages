class OpenAiError {
  final String message;
  final String code;
  final String type;
  final String param;
  const OpenAiError({
    required this.message,
    required this.code,
    required this.type,
    required this.param,
  });

  OpenAiError.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        code = json['code'],
        type = json['type'],
        param = json['param'];
}
