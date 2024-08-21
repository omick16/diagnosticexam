import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/controllers/new_habit_controller.dart';
import 'package:go_habits/screens/new_habit_screen/widgets/habit_motivation_page.dart';
import 'package:go_habits/screens/new_habit_screen/widgets/habit_schedule_page.dart';
import 'package:go_habits/screens/new_habit_screen/widgets/habit_title_page.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';

class NewHabitScreen extends StatelessWidget {
  const NewHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewHabitController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100.0,
        surfaceTintColor: AppColors.background,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  icon: const Icon(Icons.arrow_back),
                  onPressed: controller.previousPage,
                  color: AppColors.accent,
                  style: AppButtonStyle.noShapeIconButton,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 5.0,
                      child: Obx(() {
                        return LinearProgressIndicator(
                          value: (controller.currentPage.value + 1) / 3,
                          backgroundColor: AppColors.third,
                          minHeight: 5.0,
                          color: AppColors.accent,
                        );
                      }),
                    ),
                  ),
                ),
              ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: controller.onPageChanged,
              children: [
                HabitTitlePage(
                  controller: controller,
                ),
                HabitMotivationPage(
                  controller: controller,
                ),
                HabitSchedulePage(
                  controller: controller,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
            child: FilledButton(
              onPressed: controller.nextPage,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...controller.loading.value == true ? showLoading() : [],
                    Text(
                      controller.currentPage.value == 2 ? 'FINISH' : 'CONTINUE',
                      style: AppTextStyle.elevatedButtonCaption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
