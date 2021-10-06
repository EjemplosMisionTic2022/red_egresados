import 'package:firebase_database/firebase_database.dart';
import 'package:red_egresados/domain/repositorires/database.dart';

class FirestoreDB extends DatabaseInterface {
  // We get the Firestore instance
  final _dbReference = FirebaseDatabase.instance.reference();

  // With the documents collection ref we add a new document,
  // the reference will be set automatically
  @override
  Future<void> add(
      {required String collectionPath,
      required Map<String, dynamic> data}) async {
    // We generate a new unique reference for the new child.
    final newRef = _dbReference.child(collectionPath).push();
    await newRef.set(data);
  }

  // With the document reference we can add/replace it with
  // the data provided
  @override
  Future<void> addWithReference(
      {required String documentPath,
      required Map<String, dynamic> data}) async {
    await _dbReference.child(documentPath).set(data);
  }

  // We use the document reference to delete it
  @override
  Future<void> deleteDoc({required String documentPath}) async {
    await _dbReference.child(documentPath).remove();
  }

  // We read the document specified by the document reference
  @override
  Future<Map<String, dynamic>?> readDoc({required String documentPath}) async {
    DataSnapshot snapshot = await _dbReference.child(documentPath).once();
    return snapshot.value;
  }

  // We get all the documents inside the collection
  // specified by te collection reference
  @override
  Future<Map<String, dynamic>> readCollection(
      {required String collectionPath}) async {
    // Since we are going to fetch users interaction data,
    // we can establish a fetch window, 24 hours in this case.

    // IMPORTANT! This query is case specific.

    // H * m * s * ms
    const lifeSpan = 24 * 60 * 60 * 1000;
    final minimumTimestamp = DateTime.now().millisecondsSinceEpoch - lifeSpan;

    DataSnapshot snapshot = await _dbReference
        .child(collectionPath)
        .orderByChild('timestamp')
        .startAt(minimumTimestamp)
        .limitToFirst(36)
        .once();

    return snapshot.value as Map<String, dynamic>;
  }

  @override
  Stream<Event> listenCollection({required String collectionPath}) {
    // Since we are going to fetch users interaction data,
    // we can establish a fetch window, 24 hours in this case.

    // IMPORTANT! This query is case specific.

    // H * m * s * ms
    const lifeSpan = 24 * 60 * 60 * 1000;
    final minimumTimestamp = DateTime.now().millisecondsSinceEpoch - lifeSpan;

    return _dbReference
        .child(collectionPath)
        .orderByChild('timestamp')
        .startAt(minimumTimestamp)
        .limitToFirst(36)
        .onValue;
  }

  // We update the specified fields in the document
  // specified by the document reference
  @override
  Future<void> updateDoc(
      {required String documentPath,
      required Map<String, dynamic> data}) async {
    await _dbReference.child(documentPath).update(data);
  }
}
