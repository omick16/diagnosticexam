import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/controllers/habits_controller.dart';
import 'package:go_habits/screens/habits_screen/widgets/date_panel.dart';
import 'package:go_habits/utils/colors.dart';
import 'package:go_habits/utils/helper.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HabitsController controller = Get.put(HabitsController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 80.0,
            excludeHeaderSemantics: true,
            scrolledUnderElevation: 2.0,
            expandedHeight: 130.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              collapseMode: CollapseMode.parallax,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Habits", style: AppTextStyle.title),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 40,
                    height: 40,
                    // Padding around the IconButton
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Rounded corners instead of a circle
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Get.offNamed('/newHabit');
                      },
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              titlePadding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
            ),
          ),
          Obx(() {
            if (controller.loading.value) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.habits.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: Text('No habits found.')),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final habit = controller.habits[index];
                  final Map<String, List<dynamic>> days =
                      controller.getDatesFromTodayUntilDaysAgo(habit.id!, 4);
                  return Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppColors.third,
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    habit.name,
                                    style: AppTextStyle.habitTitle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    habit.motivation,
                                    style: AppTextStyle.habitMotivation,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                width: 30,
                                height: 30,
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
                                  icon: const Icon(Icons.more_horiz_outlined),
                                  onPressed: () {
                                    // Your onPressed logic here
                                  },
                                  color: AppColors.primary, // Color of the icon
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 30,
                          color: AppColors.dividerColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: days.values
                              .toList()
                              .map(
                                (data) => DatePanel(
                                  data: data,
                                  habitId: habit.id,
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  );
                },
                childCount: controller.habits.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}
