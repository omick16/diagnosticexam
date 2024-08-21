import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String? id;
  String userId;
  String name;
  String motivation;
  List<bool> schedule;
  DateTime dateAdded;

  Habit({
    this.id,
    required this.userId,
    required this.name,
    required this.motivation,
    required this.schedule,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'motivation': motivation,
      'schedule': schedule,
      'dateAdded': dateAdded,
    };
  }

  factory Habit.fromMap(String id, Map<String, dynamic> map) {
    return Habit(
      id: id,
      userId: map['userId'],
      name: map['name'],
      motivation: map['motivation'],
      schedule: List<bool>.from(map['schedule']),
      dateAdded: (map['dateAdded'] as Timestamp).toDate(),
    );
  }
}
