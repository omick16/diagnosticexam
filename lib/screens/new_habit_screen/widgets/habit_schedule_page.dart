import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/controllers/new_habit_controller.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';

class HabitSchedulePage extends StatelessWidget {
  final NewHabitController controller;
  const HabitSchedulePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            'How often do you want to\n complete this habit?',
            style: AppTextStyle.fieldLabel,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Container(
            height: 50,
            color: AppColors.background,
            child: Obx(
              () {
                return ToggleButtons(
                  isSelected: controller.daysOfTheWeek,
                  onPressed: (int index) {
                    controller.toggleDay(index);
                  },
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: Colors.white,
                  fillColor: AppColors.primary,
                  color: Colors.black,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'S',
                        style: AppTextStyle.daysOfWeekToogleButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'M',
                        style: AppTextStyle.daysOfWeekToogleButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'T',
                        style: AppTextStyle.daysOfWeekToogleButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'W',
                        style: AppTextStyle.daysOfWeekToogleButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'T',
                        style: AppTextStyle.daysOfWeekToogleButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'F',
                        style: AppTextStyle.daysOfWeekToogleButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'S',
                        style: AppTextStyle.daysOfWeekToogleButton,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
