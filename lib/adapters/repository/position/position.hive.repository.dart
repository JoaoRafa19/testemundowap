import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testemundowap/core/helpers/repository.helper.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';
import 'package:testemundowap/domain/model/position.model.dart';
import 'package:testemundowap/domain/repositorys/position/i.position.repository.dart';

class PositionHiveRepository implements IPositionRepository {
  static PositionHiveRepository? _instance;
  PositionHiveRepository._();
  static PositionHiveRepository get instance =>
      _instance ??= PositionHiveRepository._();

  static Future<Box> onOpenBox() async {
    final dir = await getApplicationDocumentsDirectory();

    final box = await Hive.openBox<String>(RepositoryHelper.positionsBucketName,
        path: dir.path);
    return box;
  }

  @override
  Future<void> clearAllPositions() async {
    final box = await onOpenBox();
    await box.clear();
    await box.flush();
    await box.close();
  }

  @override
  Future<List<PositionEntity>> getPositions() async {
    final positions = <PositionEntity>[];
    final box = await onOpenBox();
    final positionsList = box.values.toList();
    for (final position in positionsList) {
      final addPosition = PositionModel.fromJson(json.decode(position));
      if (addPosition != null) {
        positions.add(addPosition);
      }
    }
    await box.flush();
    await box.close();
    return positions;
  }

  @override
  Future<PositionEntity?> setPosition(PositionEntity position) async {
    try {
      final box = await onOpenBox();
      final jsonPosition = PositionModel.toJson(position);
      final stringPosition = json.encode(jsonPosition);
      await box.add(stringPosition);
      await box.close();
      return position;
    } catch (e) {
      return null;
    }
  }
}
