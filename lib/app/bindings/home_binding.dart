import 'package:get/get.dart';
import 'package:go_habits/app/controllers/home_controller.dart';
import 'package:go_habits/app/controllers/login_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
