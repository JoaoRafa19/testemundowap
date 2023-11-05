import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/widgets/misc/app.drawer.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';
import 'package:testemundowap/pages/main/main.controller.dart';
import 'package:testemundowap/pages/main/pages/task.page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      endDrawer: Obx(
        () => AppDrawer(
          user: controller.user.value,
          isBackgroundLocalization: controller.isBackground.value,
          changeThemeCallback: controller.changeTheme,
          enabledBackgroundLocalization:
              controller.enabledBackgroundService.value,
          isDarkMode: controller.enabledDarkMode.value,
          onStartBackGround: controller.startBackgroundService,
          onStartForeground: controller.startForegroundService,
          onStartService: controller.startService,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Pagina Principal',
          style: TextStyle(fontSize: 24),
        ),
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
                positionsList: controller.positions,
                onRefresh: controller.fetchLocations,
              )
            ],
          )),
    );
  }
}

class LocationRegister extends StatelessWidget {
  final List<PositionEntity> positionsList;
  final Future<void> Function() onRefresh;
  const LocationRegister(
      {super.key, required this.positionsList, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          itemCount: positionsList.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Text(positionsList[index].registerTime.toString()),
              ],
            );
          },
        ));
  }
}
