import 'package:get/get.dart';
import 'package:go_habits/app/controllers/new_journal_controller.dart';

class NewJournalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewJournalController>(() => NewJournalController());
  }
}
