import 'package:cloud_firestore/cloud_firestore.dart';

class Journal {
  String id;
  String habitId;
  String userId;
  String entryText;
  String imageUrl;
  DateTime calendarDate;
  DateTime dateAdded;

  Journal({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.entryText,
    required this.imageUrl,
    required this.calendarDate,
    required this.dateAdded,
  });

  // Convert LogEntry to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitId': habitId,
      'userId': userId,
      'entryText': entryText,
      'imageUrl': imageUrl,
      'calendarDate': calendarDate,
      'dateAdded': dateAdded,
    };
  }

  // Create a LogEntry from a Firestore document
  factory Journal.fromMap(String id, Map<String, dynamic> map) {
    return Journal(
      id: id,
      habitId: map['habitId'] ?? '',
      userId: map['userId'] ?? '',
      entryText: map['entryText'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      calendarDate: (map['calendarDate'] as Timestamp).toDate(),
      dateAdded: (map['dateAdded'] as Timestamp).toDate(),
    );
  }
}
