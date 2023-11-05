import 'package:get/get.dart';
import 'package:testemundowap/pages/login/login.controller.dart';

class LoginBinding implements Bindings {
  static const route = '/login';
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
