import 'package:get/get.dart';
import 'package:go_habits/app/controllers/new_habit_controller.dart';

class NewHabitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewHabitController>(() => NewHabitController());
  }
}
