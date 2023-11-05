import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:testemundowap/adapters/factory/repository.factory.dart';
import 'package:testemundowap/adapters/factory/service.factory.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';
import 'package:testemundowap/domain/usecases/save.location.usecase.dart';

class BackGroundLocalizationService {
  static const notificationChannelId = 'foreground_localization';
  static final usecase =
      SaveLocalizationUsecase(ServiceFactory(), RepositoryFactory());
  static Duration duration = const Duration(minutes: 1);
  static PositionEntity actualPosition =
      PositionEntity(logitude: 0, latitude: 0, registerTime: DateTime.now());

  static const notificationId = 888;

  static Future<void> initializeService({int? scheduleDuration}) async {
    final service = FlutterBackgroundService();
    duration = Duration(minutes: scheduleDuration ?? 1);
    const chanel = AndroidNotificationChannel(
      notificationChannelId,
      'Localização em segundo plano',
      showBadge: true,
      ledColor: Colors.green,
      enableVibration: false,
      playSound: false,
      enableLights: false,
      description: 'Sua localização está sendo salva em segundo plano',
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin localNotificationPlugin =
        FlutterLocalNotificationsPlugin();

    await localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(chanel);

    await service.configure(
        iosConfiguration: IosConfiguration(
          onForeground: onStart,
          onBackground: onIosBackground,
        ),
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: false,
          foregroundServiceNotificationId: notificationId,
          notificationChannelId: notificationChannelId,
          initialNotificationContent:
              'Sua localização está sendo salva em segundo plano.',
          initialNotificationTitle: 'Localização em segundo plano',
        ));
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  static Future<void> onStart(
    ServiceInstance service,
  ) async {
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackgound').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: 'Pegando localização',
            content:
                "\nLocalização atual: LAT:${actualPosition.latitude}\tLONG:${actualPosition.logitude}");
      }
    }

    Timer.periodic(duration, (timer) async {
      actualPosition = await usecase.execute();
      log(actualPosition.toString());
      log("Lat: ${actualPosition.latitude} Long: ${actualPosition.logitude}");
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          service.setForegroundNotificationInfo(
              title: 'Pegando localização',
              content:
                  "Localização atual: LAT:${actualPosition.latitude.toStringAsFixed(3)}\tLONG:${actualPosition.logitude.toStringAsFixed(3)}");
        }
      }
      service.invoke('update');
    });
  }
}
