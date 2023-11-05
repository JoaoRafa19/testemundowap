import 'package:get/get.dart';
import 'package:testemundowap/pages/login/login.binding.dart';
import 'package:testemundowap/pages/login/login.page.dart';
import 'package:testemundowap/pages/main/main.binding.dart';
import 'package:testemundowap/pages/main/main.page.dart';

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
    )
  ];
}
