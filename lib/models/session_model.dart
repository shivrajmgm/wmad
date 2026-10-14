import 'package:cloud_firestore/cloud_firestore.dart';

class Session {
  final String id;
  final String title;
  final String gameTitle;
  final String hostId;
  final String hostName;
  final DateTime scheduledTime;
  final String status;
  final List<String> participants;
  final String notes;

  Session({
    required this.id,
    required this.title,
    required this.gameTitle,
    required this.hostId,
    required this.hostName,
    required this.scheduledTime,
    required this.status,
    required this.participants,
    required this.notes,
  });

  factory Session.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Session(
      id: doc.id,
      title: data['title'] ?? '',
      gameTitle: data['gameTitle'] ?? '',
      hostId: data['hostId'] ?? '',
      hostName: data['hostName'] ?? '',
      scheduledTime: (data['scheduledTime'] as Timestamp).toDate(),
      status: data['status'] ?? 'Scheduled',
      participants: List<String>.from(data['participants'] ?? []),
      notes: data['notes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'gameTitle': gameTitle,
      'hostId': hostId,
      'hostName': hostName,
      'scheduledTime': Timestamp.fromDate(scheduledTime),
      'status': status,
      'participants': participants,
      'notes': notes,
    };
  }
}