import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/models/habit.dart';
import 'package:go_habits/app/models/journal.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:intl/intl.dart';

class HabitsController extends GetxController {
  var loading = false.obs;
  var habits = <Habit>[].obs;
  var journals = <String, List<Journal>>{}.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchHabits();
  }

  Future<void> fetchHabits() async {
    try {
      loading.value = true;
      User? user = auth.currentUser;

      if (user != null) {
        var snapshot = await firestore
            .collection('habits')
            .where('userId', isEqualTo: user.uid)
            .orderBy('dateAdded', descending: true)
            .get();

        habits.value = snapshot.docs
            .map((doc) {
              try {
                return Habit.fromMap(
                  doc.id,
                  doc.data(),
                );
              } catch (e) {
                Get.snackbar(
                  "Error",
                  "Error mapping document",
                  backgroundColor: AppColors.error,
                  colorText: Colors.white,
                );
                return null;
              }
            })
            .where((habit) => habit != null)
            .cast<Habit>()
            .toList();
        final today = DateTime.now();
        final fiveDaysAgo = today.subtract(const Duration(days: 5));
        for (var habit in habits) {
          final journalSnapshot = await FirebaseFirestore.instance
              .collection('habits')
              .doc(habit.id)
              .collection('journals')
              .where('userId', isEqualTo: user.uid)
              .where('calendarDate', isGreaterThanOrEqualTo: fiveDaysAgo)
              .where('calendarDate', isLessThanOrEqualTo: today)
              .orderBy('calendarDate', descending: true)
              .get();

          journals[habit.id!] = journalSnapshot.docs.map((doc) {
            return Journal.fromMap(doc.id, doc.data());
          }).toList();
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch habits",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }

  Map<String, List<dynamic>> getDatesFromTodayUntilDaysAgo(
    String habitId,
    int daysAgo,
  ) {
    DateTime today = DateTime.now();
    Map<String, List<dynamic>> journalDates = {};

    for (int i = daysAgo; i >= 0; i--) {
      DateTime date = today.subtract(Duration(days: i));
      String key = DateFormat('yMd').format(date);
      journalDates[key] = [date, null];
    }

    if (journals.containsKey(habitId)) {
      for (var journal in journals[habitId]!) {
        DateTime calendarDate = journal.calendarDate;
        String key = DateFormat('yMd').format(calendarDate);
        journalDates[key]?[1] = journal;
      }
    }

    return journalDates;
  }

  bool areDatesEqual(DateTime date1, DateTime date2) {
    final normalizedDate1 = DateTime(date1.year, date1.month, date1.day);
    final normalizedDate2 = DateTime(date2.year, date2.month, date2.day);
    return normalizedDate1 == normalizedDate2;
  }
}
