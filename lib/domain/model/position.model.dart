import 'package:testemundowap/domain/entity/position.entity.dart';

abstract class PositionModel {
  static PositionEntity? fromJson(Map<String, dynamic> json) {
    try {
      return PositionEntity(
        logitude: json['longitude'],
        latitude: json['latitude'],
        registerTime: DateTime.parse(json['time']),
      );
    } on Object {
      return null;
    }
  }

  static Map<String, dynamic> toJson(PositionEntity entity) {
    return {
      "longitude": entity.logitude,
      "latitude": entity.latitude,
      "time": entity.registerTime.toIso8601String(),
    };
  }
}
