enum Role {
  system,
  user,
  assistant,
}

class Message {
  final Role role;
  final String content;
  final String? name;

  const Message({
    required this.role,
    required this.content,
    this.name,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: Role.values.byName(json['role']),
      content: json['content'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'role': role.name,
      'content': content,
    };
    if (name != null) {
      json['name'] = name;
    }
    return json;
  }
}
