import 'package:testemundowap/domain/service/i.geolocation.service.dart';

abstract class IServiceFactory {
  IGeolocationService get createGeolocationService;
}
