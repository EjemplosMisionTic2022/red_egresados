class ChatUser {
  String name, pictureUrl, email;

  ChatUser({
    required this.name,
    required this.email,
    required this.pictureUrl,
  });

  factory ChatUser.fromJson(Map<String, dynamic> map) {
    return ChatUser(
      name: map['name'],
      email: map['email'],
      pictureUrl: map['pictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "pictureUrl": pictureUrl,
    };
  }
}
