import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testemundowap/core/widgets/app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testemundowap/domain/service/background.localization.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocumentDirectory.path);
  Hive.init(appDocumentDirectory.path);

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification
          .request()
          .then((value) => Permission.location.isDenied.then((value) {
                if (value) {
                  Permission.location.request();
                }
              }));
    }
  });

  await BackGroundLocalizationService.initializeService(scheduleDuration: 15);

  runApp(const App());
}
