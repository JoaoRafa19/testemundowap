import 'package:geolocator/geolocator.dart';
import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';
import 'package:testemundowap/domain/service/i.geolocation.service.dart';

class GetLocationService implements IGeolocationService {
  @override
  Future<PositionEntity> getLocalization() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException(message: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException(message: 'Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();

    return PositionEntity(
      logitude: position.longitude,
      latitude: position.latitude,
      registerTime: DateTime.now(),
    );
  }
}
