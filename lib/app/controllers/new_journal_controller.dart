import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/models/journal.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class NewJournalController extends GetxController {
  var loading = false.obs;
  var entry = TextEditingController();
  final int maximumCharacters = 500;
  var inputText = ''.obs;
  var hasPhoto = false.obs;
  String habitId = '';
  DateTime chosenDate = DateTime.now();

  RxInt get remainingChars => (maximumCharacters - inputText.value.length).obs;
  var selectedImagePath = ''.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      hasPhoto.value = true;
    } else {
      Get.snackbar(
        "Error",
        "No image selected",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      hasPhoto.value = true;
    } else {
      Get.snackbar(
        "Error",
        "No image captured",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  void onTextChanged(String text) {
    if (text.length > maximumCharacters) {
      text = text.substring(0, maximumCharacters);
      entry.text = text;
      entry.selection = TextSelection.fromPosition(
        TextPosition(
          offset: text.length,
        ),
      );
    }
    inputText.value = text;
  }

  Future<String?> uploadImageToFirebase() async {
    if (selectedImagePath.value.isEmpty) return null;

    try {
      File imageFile = File(selectedImagePath.value);
      String fileName =
          '${habitId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child('journals/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to upload image $e",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return null;
    }
  }

  Future<void> saveJournalEntry() async {
    try {
      loading.value = true;
      User? user = auth.currentUser;
      if (user == null) {
        throw Exception('User cant be loaded.');
      }

      String? imageUrl = await uploadImageToFirebase();
      String journalId = FirebaseFirestore.instance
          .collection('habits/$habitId/journals')
          .doc()
          .id;

      Journal journalEntry = Journal(
        id: journalId,
        habitId: habitId,
        userId: user.uid,
        entryText: entry.text,
        imageUrl: imageUrl ?? '',
        calendarDate: chosenDate,
        dateAdded: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('habits/$habitId/journals')
          .doc(journalId)
          .set(journalEntry.toMap());

      Get.snackbar(
        "Success",
        "Log entry added successfully",
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add journal entry $e",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    entry.dispose();
    super.onClose();
  }
}
