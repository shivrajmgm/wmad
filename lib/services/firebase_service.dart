import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/session_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of sessions filtered by the logged-in user's UID
  Stream<List<Session>> getSessions(String uid) {
    return _db.collection('sessions')
              .where('hostId', isEqualTo: uid)
              .snapshots().map((snapshot) => 
      snapshot.docs.map((doc) => Session.fromFirestore(doc)).toList()
    );
  }

  Future<void> addSession(Session session) async {
    await _db.collection('sessions').add(session.toMap());
  }

  Future<void> deleteSession(String sessionId) async {
    await _db.collection('sessions').doc(sessionId).delete();
  }
}