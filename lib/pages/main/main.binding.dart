import 'package:get/get.dart';
import 'package:testemundowap/pages/main/main.controller.dart';

class MainBinding implements Bindings {
  static const route = '/main';
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}
