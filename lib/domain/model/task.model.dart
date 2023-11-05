import 'package:testemundowap/domain/model/task.field.model.dart';
import 'package:testemundowap/domain/entity/field.entity.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';

abstract class TaskModel {
  static Map<String, dynamic> toJson(Task task) {
    return {
      "id": task.id,
      "task_name": task.taskName,
      "description": task.description,
      "fields": task.fields.map((e) => TaskFieldModel.toJson(e)).toList()
    };
  }

  static Task? fromJsonToEntity(Map<String, dynamic> map) {
    try {
      final fields = <TaskField>[];
      for (final field in map["fields"]) {
        fields.add(TaskFieldModel.fromJson(field));
      }

      final task = Task(
        description: map["description"],
        id: map["id"],
        fields: (map["fields"] as List)
            .map((e) => TaskFieldModel.fromJson(e))
            .toList(),
        taskName: map["task_name"],
      );
      return task;
    } catch (e) {
      return null;
    }
  }

  static List<Task> fromJson(dynamic json) {
    try {
      final taskList = <Task>[];
      for (final item in json as List) {
        final fields = <TaskField>[];
        for (final field in item["fields"]) {
          fields.add(TaskFieldModel.fromJson(field));
        }

        final task = Task(
          description: item["description"],
          id: item["id"],
          fields: (item["fields"] as List)
              .map((e) => TaskFieldModel.fromJson(e))
              .toList(),
          taskName: item["task_name"],
        );
        taskList.add(task);
      }
      return taskList;
    } catch (e) {
      return [];
    }
  }
}
