import 'package:testemundowap/domain/entity/task.entity.dart';

abstract class ITaskRepository {
  Future<Task?> saveTask(Task task);
  Future<Task?> getTask(int taskId);
  Future<Task?> updateTask(int taskId, Task newTask);
  Future<List<Task>?> getAll();
}
