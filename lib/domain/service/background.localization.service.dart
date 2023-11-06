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
  static Duration duration = const Duration(minutes: 3);
  static PositionEntity actualPosition =
      PositionEntity(logitude: 0, latitude: 0, registerTime: DateTime.now());

  static const notificationId = 888;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> initializeService({int? scheduleDuration}) async {
    final service = FlutterBackgroundService();
    duration = Duration(minutes: scheduleDuration ?? 3);
    log(duration.toString());

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId, // id
      notificationChannelId, // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.low, // importance must be at low or higher level
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
        iosConfiguration: IosConfiguration(
          onBackground: (i) async {
            await onStart(i);
            return true;
          },
          onForeground: onStart,
        ),
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          // auto start service
          autoStart: true,
          isForegroundMode: true,

          notificationChannelId:
              notificationChannelId, // this must match with notification channel you created above.
          initialNotificationTitle: 'AWESOME SERVICE',
          initialNotificationContent: 'Initializing',
          foregroundServiceNotificationId: notificationId,
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
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: 'Salvando sua localização', content: "");
      }
    }

    Timer.periodic(duration, (timer) async {
      actualPosition = await usecase.execute();
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
            title: 'Pegando localização',
            content:
                "\nLocalização atual: LAT:${actualPosition.latitude}\tLONG:${actualPosition.logitude}");
        flutterLocalNotificationsPlugin.show(
          notificationId,
          "Pegando localização",
          '\nLocalização atual: LAT:${actualPosition.latitude}\tLONG:${actualPosition.logitude}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannelId,
              notificationChannelId,
              ongoing: true,
            ),
          ),
        );
      }
      log("Lat: ${actualPosition.latitude} Long: ${actualPosition.logitude}");
      service.invoke('update');
    });
  }
}
