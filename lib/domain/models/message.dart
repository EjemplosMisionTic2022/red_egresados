class ChatMessage {
  String sender, message;
  String? reference;
  int? timestamp;

  ChatMessage(
      {required this.message,
      required this.sender,
      this.reference,
      this.timestamp});

  factory ChatMessage.fromJson(Map<String, dynamic> map) {
    final data = map["data"] ?? map;
    return ChatMessage(
        message: data['message'],
        sender: data['sender'],
        timestamp: data['timestamp'],
        reference: map['ref'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "sender": sender,
      "timestamp": timestamp ?? DateTime.now().millisecondsSinceEpoch,
    };
  }
}
