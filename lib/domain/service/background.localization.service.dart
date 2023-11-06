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
  static Duration duration = const Duration(minutes: 5);
  static PositionEntity actualPosition =
      PositionEntity(logitude: 0, latitude: 0, registerTime: DateTime.now());

  static const notificationId = 888;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> initializeService({int? scheduleDuration}) async {
    final service = FlutterBackgroundService();
    duration = Duration(minutes: scheduleDuration ?? 5);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId, // id
      'MY FOREGROUND SERVICE', // title
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

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.show(notificationId, "Pegando localização",
            "Pegando localização em segundo plano!",
            notificationDetails: const AndroidNotificationDetails(
              notificationChannelId,
              notificationChannelId,
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

    service.on('setAsForeground').listen((event) {
      service.invoke("setForegroundMode", {
        'value': true,
      });
    });
    service.on('setAsBackgound').listen((event) {
      service.invoke("setForegroundMode", {
        'value': false,
      });
    });
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
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          await flutterLocalNotificationsPlugin.show(
            notificationId,
            "Pegando localização",
            '\nLocalização atual: LAT:${actualPosition.latitude}\tLONG:${actualPosition.logitude}',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                notificationChannelId,
                'MY FOREGROUND SERVICE',
                icon: 'ic_bg_service_small',
                ongoing: true,
              ),
            ),
          );
        }
      }
      log(actualPosition.toString());
      log("Lat: ${actualPosition.latitude} Long: ${actualPosition.logitude}");
      service.invoke('update');
    });
  }
}
