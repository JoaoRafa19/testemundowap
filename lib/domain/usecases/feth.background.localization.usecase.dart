import 'dart:developer';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:testemundowap/core/helpers/permissions.helper.dart';
import 'package:testemundowap/domain/service/background.localization.service.dart';

class BackGroundLocalizationUsecase {
  BackGroundLocalizationUsecase();

  Future<bool> execute(
      {bool? isBackground, bool? stop, int? scheduleDurationMinutes}) async {
    try {
      await PermissionHander.handlePermissions();
      final service = FlutterBackgroundService();

      if (stop == true) {
        if (await service.isRunning()) {
          FlutterBackgroundService().invoke('stopService');
          return false;
        }
      } else {
        if (await service.isRunning() == false) {
          await BackGroundLocalizationService.initializeService(
              scheduleDuration: scheduleDurationMinutes);
        }
      }

      if (await service.isRunning()) {
        FlutterBackgroundService().invoke('setAsBackgound');
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
