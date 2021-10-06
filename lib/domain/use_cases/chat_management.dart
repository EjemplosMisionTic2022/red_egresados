import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:red_egresados/data/repositories/chat/firestore_database.dart';
import 'package:red_egresados/data/repositories/chat/realtime_database.dart';
import 'package:red_egresados/domain/models/chat.dart';
import 'package:red_egresados/domain/models/message.dart';

class ChatManager {
  FirestoreChat firestore = FirestoreChat();
  RealTimeChat realtime = RealTimeChat();

  // Chats

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList(String localEmail) {
    return firestore.getChatRecords(localEmail);
  }

  Future<Chat?> checkIfChatExist(String emailA, String emailB) async {
    final chat = await firestore.checkIfRecordExist(emailA, emailB);
    return chat != null ? Chat.fromJson(chat) : null;
  }

  Future<String> createChat(Chat chat) async {
    final chatReference =
        await realtime.createChat(message: chat.lastMessage.toJson());
    chat.reference = chatReference;
    await firestore.createChatRecord(chat: chat.toJson());
    return chatReference;
  }

  Future<void> updateChat(Chat chat) async {
    await firestore.updateChatRecord(
        recordPath: chat.recordReference!, chat: chat.toJson());
  }

  List<Chat> extractChats(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final chatsData = firestore.extractDocs(snapshot);
    return _extractChatInstances(chatsData);
  }

  List<Chat> _extractChatInstances(List<Map<String, dynamic>> data) {
    List<Chat> chats = [];
    for (var chat in data) {
      chats.add(
        Chat.fromJson(chat),
      );
    }
    return chats;
  }

  // Messages

  Stream<Event> getChatStream({required String chatReference}) {
    return realtime.connectChat(chatPath: chatReference);
  }

  Future<void> sendMessage(Chat chat) async {
    await realtime.sendMessage(
        chatPath: chat.reference!, message: chat.lastMessage.toJson());
    await updateChat(chat);
  }

  Future<void> deleteMessage(String chatReference, ChatMessage message) async {
    await realtime.deleteMessage(
        chatPath: chatReference, messagePath: message.reference!);
  }

  List<ChatMessage> extractMessages(DataSnapshot snapshot) {
    final chatsData = realtime.extractDocs(snapshot);
    return _extractMessagesInstances(chatsData);
  }

  List<ChatMessage> _extractMessagesInstances(List<Map<String, dynamic>> data) {
    List<ChatMessage> chats = [];
    for (var chat in data) {
      chats.add(
        ChatMessage.fromJson(chat),
      );
    }
    return chats;
  }
}
