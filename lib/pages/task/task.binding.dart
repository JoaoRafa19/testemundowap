import 'package:get/get.dart';
import 'package:testemundowap/pages/task/task.controller.dart';

class TaskBinding implements Bindings {
  static const route = '/task';
  @override
  void dependencies() {
    Get.put<TaskController>(TaskController());
  }
}
