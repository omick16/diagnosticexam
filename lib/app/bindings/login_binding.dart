import 'package:get/get.dart';
import 'package:go_habits/app/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.put<LoginController>(LoginController());
  }
}
