import 'package:flutter/material.dart';
import '../models/session_model.dart';
import '../services/firebase_service.dart';

class SessionProvider extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  List<Session> _sessions = [];

  List<Session> get sessions => _sessions;

  // Pass the UID in to only load this user's data
  void loadUserSessions(String uid) {
    _service.getSessions(uid).listen((sessionList) {
      _sessions = sessionList;
      notifyListeners();
    });
  }

  Future<void> addSession(Session session) async {
    await _service.addSession(session);
  }

  Future<void> deleteSession(String id) async {
    await _service.deleteSession(id);
  }
}