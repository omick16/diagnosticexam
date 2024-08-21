import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_habits/app/models/habit.dart';
import 'package:go_habits/utils/colors.dart';

class NewHabitController extends GetxController {
  var currentPage = 0.0.obs;
  var loading = false.obs;
  final pageController = PageController();
  final habitTitle = TextEditingController().obs;
  final habitMotivation = TextEditingController().obs;
  var daysOfTheWeek = [true, true, true, true, true, true, true].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void onPageChanged(int page) {
    currentPage.value = page.toDouble();
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (currentPage.value == 2) {
      addHabit();
    }
  }

  void previousPage() {
    if (currentPage.value == 0) {
      Get.offAllNamed('/home');
    } else {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void toggleDay(int index) {
    daysOfTheWeek[index] = !daysOfTheWeek[index];
  }

  Future<void> addHabit() async {
    try {
      User? user = auth.currentUser;
      loading.value = true;
      if (user != null) {
        Habit newHabit = Habit(
          userId: user.uid,
          name: habitTitle.value.text,
          motivation: habitMotivation.value.text,
          schedule: daysOfTheWeek,
          dateAdded: DateTime.now(),
        );
        await firestore.collection('habits').add(newHabit.toMap());
        Get.snackbar(
          'Success',
          'Habit added successfully!',
          backgroundColor: AppColors.success,
          colorText: Colors.white,
        );

        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          'Error',
          'No user is signed in',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add habit');
    } finally {
      loading.value = false; // Hide the progress indicator
    }
  }
}
