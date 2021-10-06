import 'package:cloud_firestore/cloud_firestore.dart';

class UserJob {
  String picUrl, name, email, message;
  String? dbRef;

  UserJob({
    required this.picUrl,
    required this.name,
    required this.email,
    required this.message,
    this.dbRef,
  });

  factory UserJob.fromJson(Map<String, dynamic> map) {
    final data = map["data"];
    return UserJob(
        picUrl: data['picUrl'],
        name: data['name'],
        email: data['email'],
        message: data['message'],
        dbRef: map['ref']);
  }

  Map<String, dynamic> toJson() {
    return {
      "picUrl": picUrl,
      "name": name,
      "email": email,
      "message": message,
      "timestamp": Timestamp.now(),
    };
  }
}
