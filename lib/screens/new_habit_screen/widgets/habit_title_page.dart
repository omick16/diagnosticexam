import 'package:flutter/material.dart';
import 'package:go_habits/app/controllers/new_habit_controller.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';

class HabitTitlePage extends StatelessWidget {
  final NewHabitController controller;
  const HabitTitlePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            'What is the name of your new habit?',
            style: AppTextStyle.fieldLabel,
          ),
          const SizedBox(height: 15),
          Center(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: AppColors.textFieldColor,
              ),
              width: double.infinity,
              child: TextField(
                autofocus: true,
                controller: controller.habitTitle.value,
                style: AppTextStyle.textField,
                minLines: 1,
                maxLines: 6,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
