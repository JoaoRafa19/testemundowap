import 'package:testemundowap/domain/entity/position.entity.dart';

abstract class IGeolocationService {
  Future<PositionEntity> getLocalization();
}
