import 'package:cloud_firestore/cloud_firestore.dart';

class EventService {
  final CollectionReference _firestore = FirebaseFirestore.instance.collection('events');

  //* CREATE : new event
  Future<void> createEvent({
    required String title,
    required String description,
    required DateTime date,
  }) async {
    await _firestore.add({'title': title, 'description': description, 'date': date});
  }
  
  //* READ : get all event
  Stream<QuerySnapshot> getEvents() {
    return _firestore.snapshots();
  }

  //* UPDATE : update event
  Future<void> updateEvent({
    required String id,
    required String title,
    required String description,
    required DateTime date,
  }) async {
    await _firestore.doc(id).update({
      'title': title, 
      'description': description, 
      'date': date
    });
  }

  //* DELETE : delete event
  Future<void> deleteEvent({required String id}) async {
    await _firestore.doc(id).delete();
  }
}