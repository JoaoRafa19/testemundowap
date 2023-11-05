import 'package:testemundowap/domain/entity/field.entity.dart';

class Task {
  final int? hiveId;
  final int id;
  final String taskName;
  final String description;
  final List<TaskField> fields;

  Task(
      {required this.id,
      required this.taskName,
      required this.description,
      required this.fields,
      this.hiveId});
}
