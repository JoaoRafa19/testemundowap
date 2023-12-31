import 'package:testemundowap/domain/entity/field.entity.dart';

abstract class TaskFieldModel {
  static TaskField fromJson(dynamic json) {
    return TaskField(
        id: json["id"],
        label: json["label"],
        isRequired: json["required"],
        fieldType: json["field_type"],
        completed: json["completed"],
        value: json["value"],
        edited: json["edited"]);
  }

  static Map<String, dynamic> toJson(TaskField field) {
    return {
      "id": field.id,
      "label": field.label,
      "required": field.isRequired,
      "field_type": field.fieldType,
      "completed": field.completed,
      "edited": field.edited,
      "value": field.value,
    };
  }
}
