import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testemundowap/core/routes/routes.dart';
import 'package:testemundowap/core/theme/core.theme.data.dart';
import 'package:testemundowap/pages/login/login.binding.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isDarkMode = true;
  static const isDarkModeKey = 'darkTheme';

  _fetchSettings() async {
    final sharedPref = await SharedPreferences.getInstance();

    setState(() {
      isDarkMode = sharedPref.getBool(isDarkModeKey) ?? true;
    });

    Get.changeTheme(isDarkMode ? ThemeData.dark() : ThemeData.light());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teste Mundo WAP',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(textTheme: AppTheme.textTheme)
          : ThemeData.light().copyWith(textTheme: AppTheme.textTheme),
      initialRoute: LoginBinding.route,
      getPages: AppRouter.routes,
    );
  }
}
