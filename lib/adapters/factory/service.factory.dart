import 'package:testemundowap/adapters/service/geolocator.service.dart';
import 'package:testemundowap/domain/factory/i.service.factory.dart';
import 'package:testemundowap/domain/service/i.geolocation.service.dart';

class ServiceFactory implements IServiceFactory{
  @override
  IGeolocationService get createGeolocationService => GetLocationService();

}