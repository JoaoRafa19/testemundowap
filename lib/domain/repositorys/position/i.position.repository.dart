import 'package:testemundowap/domain/entity/position.entity.dart';

abstract class IPositionRepository {
  Future<PositionEntity?> setPosition(PositionEntity position);
  Future<List<PositionEntity>> getPositions();
  Future<void> clearAllPositions();
}
