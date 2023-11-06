import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/repositorys/tasks/i.task.respositoy.dart';

class GetTaskUsecase {
  late ITaskRepository _taskRepository;

  GetTaskUsecase(IRepositoryFactory repositoryFactory) {
    _taskRepository = repositoryFactory.createTaskRepository;
  }

  Future<Task?> execute(int taskId) async {
    try {
      final task = await _taskRepository.getTask(taskId);
      if (task == null) {
        throw FetchTasksException(message: 'Não foi possível achar a tarefa');
      }
      return task;
    } catch (e) {
      throw FetchTasksException(message: "Erro inesperado ao buscar a tarefa");
    }
  }
}
