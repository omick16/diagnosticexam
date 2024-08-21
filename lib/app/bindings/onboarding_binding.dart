import 'package:get/get.dart';
import 'package:go_habits/app/controllers/login_controller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
