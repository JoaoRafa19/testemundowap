// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/widgets/misc/app.drawer.dart';
import 'package:testemundowap/pages/main/main.controller.dart';
import 'package:testemundowap/pages/main/pages/localizations.page.dart';
import 'package:testemundowap/pages/main/pages/task.page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      endDrawer: Obx(
        () => AppDrawer(
            duration: controller.duration.value,
            changeDurationCallback: (value) {
              controller.duration.value = value;
            },
            user: controller.user.value,
            isBackgroundLocalization: controller.isBackground.value,
            changeThemeCallback: controller.changeTheme,
            enabledBackgroundLocalization:
                controller.enabledBackgroundService.value,
            isDarkMode: controller.enabledDarkMode.value,
            onStartService: controller.startService),
      ),
      appBar: AppBar(
        title: Hero(
            tag: "title",
            child: Text(
              "Teste Mundo WAP",
              style: Theme.of(context).textTheme.displayMedium,
            )),
        leading: Container(),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.pageIndex.value,
          onTap: (value) {
            controller.pageIndex.value = value;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Tarefas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Registro de localizações',
            )
          ],
        );
      }),
      body: Obx(() => IndexedStack(
            index: controller.pageIndex.value,
            children: [
              TasksPage(
                taskList: controller.taskList,
                onRefresh: controller.fetchTasks,
              ),
              LocationRegister(
                positionsList: controller.positions.value,
                onRefresh: controller.fetchLocations,
              )
            ],
          )),
    );
  }
}
