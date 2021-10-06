import 'package:firebase_database/firebase_database.dart';
import 'package:red_egresados/data/repositories/realtime_database.dart';

class RealTimeChat extends RealTimeDB {
  // Create a new chat and return its reference
  Future<String> createChat({required Map<String, dynamic> message}) async {
    // We generate a new unique reference for the new chat.
    final chatRef = super.databaseReference.child("chats").push();
    await super.add(collectionPath: chatRef.path, data: message);
    return chatRef.path;
  }

  // Adds a new message to the referenced chat
  Future<void> sendMessage(
      {required String chatPath, required Map<String, dynamic> message}) async {
    await super.add(collectionPath: chatPath, data: message);
  }

  // Gets the stream of the chat
  Stream<Event> connectChat({required String chatPath}) {
    return super.listenCollection(collectionPath: chatPath);
  }

  // Deletes a specific message within an specifi chat
  Future<void> deleteMessage(
      {required String chatPath, required String messagePath}) async {
    final messageRef =
        super.databaseReference.child(chatPath).child(messagePath);
    await super.deleteDoc(documentPath: messageRef.path);
  }
}
