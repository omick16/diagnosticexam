import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/controllers/new_journal_controller.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';

class NewJournalScreen extends StatelessWidget {
  const NewJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewJournalController controller = Get.find();
    final arguments = Get.arguments as Map<String, dynamic>;
    final DateTime date = arguments['date'];
    final habitId = arguments['habitId'];
    controller.habitId = habitId;
    controller.chosenDate = date;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100.0,
        surfaceTintColor: AppColors.background,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("New Habit Journal", style: AppTextStyle.title),
              Container(
                padding: const EdgeInsets.all(0.0),
                width: 50,
                height: 50,
                // Padding around the IconButton
                decoration: BoxDecoration(
                  color: AppColors.third,
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // Rounded corners instead of a circle
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  color: AppColors.accent,
                  style: AppButtonStyle.noShapeIconButton,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reflect on your progress today',
                style: AppTextStyle.fieldLabel,
                textAlign: TextAlign.left,
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: AppColors.textFieldColor,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () => controller.hasPhoto.value == true
                          ? AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  color: AppColors.third,
                                ),
                                child: Image.file(
                                  File(
                                    controller.selectedImagePath.value,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    TextField(
                      autofocus: true,
                      onChanged: controller.onTextChanged,
                      controller: controller.entry,
                      style: AppTextStyle.textField,
                      minLines: 1,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Obx(
                      () => Text(
                        '${controller.remainingChars}/${controller.maximumCharacters}',
                        style: AppTextStyle.remainingCharacters,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors
                          .white, // Optional background color inside the shadow
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      icon: const Icon(Icons.photo_album),
                      onPressed: () {
                        controller.pickImageFromGallery();
                      },
                      color: AppColors.primary, // Color of the icon
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors
                          .white, // Optional background color inside the shadow
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      icon: const Icon(Icons.camera),
                      onPressed: () {
                        controller.pickImageFromCamera();
                      },
                      color: AppColors.primary, // Color of the icon
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
        child: FilledButton(
          onPressed: () {
            controller.saveJournalEntry();
          },
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...controller.loading.value == true ? showLoading() : [],
                Text(
                  'SAVE JOURNAL',
                  style: AppTextStyle.elevatedButtonCaption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> showLoading() {
    return [
      const SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 20.0),
    ];
  }
}
