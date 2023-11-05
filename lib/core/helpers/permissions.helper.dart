import 'package:permission_handler/permission_handler.dart';

class PermissionHander {
  static Future handlePermissions() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
        Permission.location.isDenied
            .then((value) => Permission.location.request());
      }
    });
  }
}
