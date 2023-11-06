import 'dart:developer';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:testemundowap/core/helpers/permissions.helper.dart';
import 'package:testemundowap/domain/service/background.localization.service.dart';

class BackGroundLocalizationUsecase {
  BackGroundLocalizationUsecase();

  Future<void> execute(
      {bool? isBackground, bool? stop, int? scheduleDurationMinutes}) async {
    try {
      await PermissionHander.handlePermissions();
      final service = FlutterBackgroundService();

      if (stop == true) {
        if (await service.isRunning()) {
          FlutterBackgroundService().invoke('stopService');
        }
      } else {
        await BackGroundLocalizationService.initializeService(
            scheduleDuration: scheduleDurationMinutes);
        FlutterBackgroundService().invoke('startService');
      }

      if (isBackground == null || isBackground) {
        FlutterBackgroundService().invoke('setAsBackgound');
      } else {
        FlutterBackgroundService().invoke('setAsForeground');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
