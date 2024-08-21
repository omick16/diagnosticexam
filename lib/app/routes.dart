import 'dart:core';
import 'package:get/get.dart';
import 'package:go_habits/app/bindings/home_binding.dart';
import 'package:go_habits/app/bindings/login_binding.dart';
import 'package:go_habits/app/bindings/new_habit_binding.dart';
import 'package:go_habits/app/bindings/new_journal_binding.dart';
import 'package:go_habits/app/bindings/onboarding_binding.dart';
import 'package:go_habits/screens/habits_screen/habits_screen.dart';
import 'package:go_habits/screens/home_screen/home_screen.dart';
import 'package:go_habits/screens/login_screen/login_screen.dart';
import 'package:go_habits/screens/new_habit_screen/new_habit_screen.dart';
import 'package:go_habits/screens/new_journal_screen/new_journal_screen.dart';
import 'package:go_habits/screens/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String onBoarding = '/onBoarding';
  static const String home = '/home';
  static const String habits = '/habits';
  static const String newHabit = '/newHabit';
  static const String profile = '/profile';
  static const String newJournal = '/newJournal';

  static final routes = [
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: onBoarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: habits,
      page: () => const HabitsScreen(),
    ),
    GetPage(
      name: newHabit,
      page: () => const NewHabitScreen(),
      transition: Transition.topLevel,
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
      opaque: false,
      binding: NewHabitBinding(),
    ),
    GetPage(
      name: newJournal,
      page: () => const NewJournalScreen(),
      transition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 300),
      opaque: false,
      binding: NewJournalBinding(),
    ),
  ];
}
