import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/repositorys/tasks/i.task.respositoy.dart';

class FetchTasksUsecase {
  late ITaskRepository _taskRepository;

  FetchTasksUsecase(IRepositoryFactory repositoryFactory) {
    _taskRepository = repositoryFactory.createTaskRepository;
  }

  Future<List<Task>> execute() async {
    try {
      final tasks = await _taskRepository.getAll();
      if (tasks == null) {
        throw FetchTasksException(message: "Sem tarefas!");
      }
      return tasks;
    } on InternalException {
      rethrow;
    } catch (e) {
      throw FetchTasksException(
          message: "não foi possível carregar as tarefas.");
    }
  }
}
