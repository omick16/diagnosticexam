import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_habits/app/controllers/home_controller.dart';
import 'package:go_habits/screens/habits_screen/habits_screen.dart';
import 'package:go_habits/screens/profile_screen/profile_screen.dart';
import 'package:go_habits/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> pages = [const HabitsScreen()];

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return const HabitsScreen();
          default:
            return const ProfileScreen();
        }
      }),
      bottomNavigationBar: CurvedNavigationBar(
        color: AppColors.accent,
        buttonBackgroundColor: AppColors.primary,
        backgroundColor: AppColors.background,
        onTap: controller.changePage,
        items: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.psychology,
              size: 30,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
