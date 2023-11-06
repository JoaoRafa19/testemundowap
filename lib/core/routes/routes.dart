import 'package:get/get.dart';
import 'package:testemundowap/core/routes/arguments.dart';
import 'package:testemundowap/pages/login/login.binding.dart';
import 'package:testemundowap/pages/login/login.page.dart';
import 'package:testemundowap/pages/main/main.binding.dart';
import 'package:testemundowap/pages/main/main.page.dart';
import 'package:testemundowap/pages/task/task.binding.dart';
import 'package:testemundowap/pages/task/task.form.page.dart';

abstract class AppRouter {
  static List<GetPage> routes = [
    GetPage(
      name: LoginBinding.route,
      bindings: [LoginBinding()],
      page: () => LoginPage(),
    ),
    GetPage(
      name: MainBinding.route,
      bindings: [MainBinding()],
      showCupertinoParallax: true,
      maintainState: true,
      transition: Transition.cupertino,
      page: () => const MainPage(),
    ),
    GetPage(
      name: TaskBinding.route,
      bindings: [TaskBinding()],
      arguments: TaskScreenArgument,
      page: () => TaskFormPage(),
    )
  ];
}
