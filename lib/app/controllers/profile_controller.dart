import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  var profileName = ''.obs;
  var selectedDate = ''.obs;
  var loading = false.obs;
  var loadingEntries = false.obs;
  var imageUrl = ''.obs;

  var selectedDateTime = DateTime.now().obs;
  var selectedIndex = 0.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  Future<void> initializeUser() async {
    DateTime today = DateTime.now();
    DateFormat dateFormat = DateFormat('EEEE, MMMM d');
    selectedDate.value = dateFormat.format(today);

    try {
      loading.value = true;
      User? user = auth.currentUser;

      if (user != null) {
        profileName.value = getFirstName(user.displayName ?? '');
        imageUrl.value = user.photoURL ?? '';
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to initialize user.",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }

  String getFirstName(String text) {
    List<String> words = text.split(' ');
    return words.isNotEmpty ? words[0] : '';
  }

  List<DateTime> getDatesFromTodayUntilDaysAgo(int daysAgo) {
    List<DateTime> dates = [];
    DateTime today = DateTime.now();

    for (int i = 0; i <= daysAgo; i++) {
      DateTime date = today.subtract(Duration(days: i));
      dates.add(date);
    }

    return dates;
  }

  Future<List<Map<String, dynamic>>> getHabitsWithJournalDate(
      DateTime myDate) async {
    DateTime startOfDay = DateTime(myDate.year, myDate.month, myDate.day);
    DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    List<Map<String, dynamic>> habitsWithJournal = [];

    try {
      loadingEntries.value = true;
      User? user = auth.currentUser;
      var habitsQuery = await firestore
          .collection('habits')
          .where('userId', isEqualTo: user!.uid)
          .get();

      for (var habitDoc in habitsQuery.docs) {
        var journalEntriesQuery = await habitDoc.reference
            .collection('journals')
            .where('userId', isEqualTo: user.uid)
            .where('calendarDate', isGreaterThanOrEqualTo: startOfDay)
            .where('calendarDate', isLessThan: endOfDay)
            .get();

        if (journalEntriesQuery.docs.isNotEmpty) {
          // If there are log entries for the date, add them to the list
          habitsWithJournal.add({
            'habit': habitDoc.data(),
            'habitId': habitDoc.id,
            'journals':
                journalEntriesQuery.docs.map((doc) => doc.data()).toList(),
          });
        }
      }
      return habitsWithJournal;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch habits and journal entries.",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return [];
    } finally {
      loadingEntries.value = false;
    }
  }

  void setSelectedDate(DateTime myDate) {
    selectedDateTime.value = myDate;
    DateFormat dateFormat = DateFormat('EEEE, MMMM d');
    selectedDate.value = dateFormat.format(myDate);
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
