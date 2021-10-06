import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_egresados/data/repositories/firestore_database.dart';

class FirestoreChat extends FirestoreDatabase {
  // This file refers to the management of the chat previews (records)

  // Creates a record of a new file between two users
  Future<void> createChatRecord({required Map<String, dynamic> chat}) async {
    await super.add(collectionPath: 'user-chats', data: chat);
  }

  // Updates the record so it reflects the last change to the user
  Future<void> updateChatRecord(
      {required String recordPath, required Map<String, dynamic> chat}) async {
    await super.updateDoc(documentPath: recordPath, data: chat);
  }

  // When the chat action is triggered outside the record list,
  // we check if a chat between those two users already exist
  Future<Map<String, dynamic>?> checkIfRecordExist(
      String emailA, String emailB) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await super
        .databaseInstance
        .collection('user-chats')
        // We get the document that have both users as members.
        .where('users.${emailA.replaceAll('.', '')}', isEqualTo: true)
        .where('users.${emailB.replaceAll('.', '')}', isEqualTo: true)
        .get();
    final docs = super.extractDocs(snapshot);
    return docs.isNotEmpty ? docs.first : null;
  }

  // We fetch a stream of the chat records that the users is member of
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRecords(
      String localEmail) {
    return super
        .databaseInstance
        .collection('user-chats')
        .where('users.${localEmail.replaceAll('.', '')}', isEqualTo: true)
        .snapshots();
  }
}
