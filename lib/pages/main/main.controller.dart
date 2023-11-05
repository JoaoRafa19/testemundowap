import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testemundowap/adapters/factory/repository.factory.dart';
import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/domain/entity/user.entity.dart';
import 'package:testemundowap/domain/usecases/fetch.locations.usecase.dart';
import 'package:testemundowap/domain/usecases/fetch.personal.information.usecase.dart';
import 'package:testemundowap/domain/usecases/fetch.tasks.usecase.dart';
import 'package:testemundowap/domain/usecases/feth.background.localization.usecase.dart';

class MainController extends GetxController {
  MainController();

  final _fetchcTasksUsecase = FetchTasksUsecase(RepositoryFactory());
  final _fetchPersonalInfoUsecase =
      FetchPersonalInformationUsecase(RepositoryFactory());
  final _backgroundLocalizationUsecase = BackGroundLocalizationUsecase();
  final _fetchLocationsUsecase = FetchLocationsUsecase(RepositoryFactory());
  @override
  void onInit() {
    fetchTasks();
    fetchUserInformation();
    fetchSettings();
    super.onInit();
  }

  final pageIndex = 0.obs;

  final duration = (15.0).obs;

  final positions = <PositionEntity>[].obs;
  final taskList = <Task>[].obs;
  final user = User(name: 'NA', profile: 'NA').obs;
  static const isDarkModeKey = 'darkTheme';
  static const enabledBackgroundLocalizationKey = 'localization';
  final enabledDarkMode = true.obs;
  final isBackground = false.obs;
  final enabledBackgroundService = false.obs;

  Future fetchTasks() async {
    try {
      taskList.clear();
      final tasks = await _fetchcTasksUsecase.execute();
      taskList.addAll(tasks);
    } on InternalException catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: e.message,
      ));
    }
  }

  Future fetchUserInformation() async {
    try {
      final userInfo = await _fetchPersonalInfoUsecase.execute();
      user.value = userInfo;
    } on InternalException catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: e.message,
      ));
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Error',
        message: ' Erro inesperado',
      ));
    }
  }

  Future fetchSettings() async {
    try {
      final sp = await SharedPreferences.getInstance();
      enabledDarkMode.value = sp.getBool(isDarkModeKey) ?? true;
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Error',
        message: ' Erro inesperado',
      ));
    }
  }

  Future changeTheme(bool isDarkMode) async {
    if (isDarkMode) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
    enabledDarkMode.value = isDarkMode;
  }

  Future startService(bool start) async {
    if (start) {
      _backgroundLocalizationUsecase.execute(
        isBackground: isBackground.value,
      );
    } else {
      _backgroundLocalizationUsecase.execute(
          isBackground: isBackground.value, stop: true);
    }
    enabledBackgroundService.value = start;
  }

  Future startForegroundService() async {
    await BackGroundLocalizationUsecase()
        .execute(isBackground: false, scheduleDurationMinutes: 1);
  }

  Future startBackgroundService() async {
    await BackGroundLocalizationUsecase()
        .execute(isBackground: true, scheduleDurationMinutes: 1);
    if (enabledBackgroundService.value) {
      enabledBackgroundService.value = false;
    } else {
      enabledBackgroundService.value = true;
    }
  }

  Future fetchLocations() async {
    try {
      positions.clear();
      final retrievedPositions = await _fetchLocationsUsecase.execute();
      positions.addAll(retrievedPositions);
    } on InternalException catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: e.message,
      ));
    }
  }
}
