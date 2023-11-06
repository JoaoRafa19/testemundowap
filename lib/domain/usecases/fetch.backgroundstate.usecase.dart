import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/core/helpers/permissions.helper.dart';

class BackgroundStateUsecase {
  BackgroundStateUsecase();

  Future<bool> execute() async {
    try {
      await PermissionHander.handlePermissions();
      final service = FlutterBackgroundService();
      return await service.isRunning();
    } catch (e) {
      throw GetBackgroundError(message: 'Não foi possivle verificar o serviço');
    }
  }
}
