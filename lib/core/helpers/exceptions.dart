abstract class InternalException implements Exception {
  final String message;
  InternalException({required this.message});
}

class LoginResultExcetption extends InternalException {
  LoginResultExcetption({required super.message});
}

class GatewayException extends InternalException {
  GatewayException({required super.message});
}

class FetchTasksException extends InternalException {
  FetchTasksException({required super.message});
}
class FetchLocationsException extends InternalException {
  FetchLocationsException({required super.message});
}

class LocationException extends InternalException {
  LocationException({required super.message});
}

class SaveLocalizationException extends InternalException {
  SaveLocalizationException({required super.message});
}

class GetUserInformationException extends InternalException {
  GetUserInformationException({required super.message});
}
