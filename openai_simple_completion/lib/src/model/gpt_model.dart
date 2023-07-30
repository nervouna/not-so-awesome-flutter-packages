abstract class GptModel {
  final String name;
  final int contextTokenLimit;
  const GptModel({
    required this.name,
    required this.contextTokenLimit,
  });
  factory GptModel.fromName(String name) {
    switch (name) {
      case 'gpt-3.5-turbo':
        return const Gpt35Turbo();
      case 'gpt-3.5-turbo-16k':
        return const Gpt35Turbo16k();
      case 'gpt-4':
        return const Gpt4();
      case 'gpt-4-32k':
        return const Gpt432k();
      default:
        throw ArgumentError.value(name, 'name', 'Invalid model name');
    }
  }
}

class Gpt35Turbo extends GptModel {
  const Gpt35Turbo() : super(name: 'gpt-3.5-turbo', contextTokenLimit: 4096);
}

class Gpt35Turbo16k extends GptModel {
  const Gpt35Turbo16k()
      : super(name: 'gpt-3.5-turbo-16k', contextTokenLimit: 16384);
}

class Gpt4 extends GptModel {
  const Gpt4() : super(name: 'gpt-4', contextTokenLimit: 8192);
}

class Gpt432k extends GptModel {
  const Gpt432k() : super(name: 'gpt-4-32k', contextTokenLimit: 32768);
}
