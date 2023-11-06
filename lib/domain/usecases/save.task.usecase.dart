import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/repositorys/tasks/i.task.respositoy.dart';

class SaveTaskUsecase {
  late ITaskRepository _taskRepository;

  SaveTaskUsecase(IRepositoryFactory repositoryFactory) {
    _taskRepository = repositoryFactory.createTaskRepository;
  }

  Future<Task> execute(Task? task) async {
    try {
      if (task != null) {
        final newTask = await _taskRepository.updateTask(task.id, task);
        if (newTask == null) {
          throw SaveTasksException(message: "Erro ao atualizar a tarefa.");
        }
        return newTask;
      }
      throw SaveTasksException(message: "Sem tarefa para salvar");
    } on InternalException {
      rethrow;
    } catch (e) {
      throw SaveTasksException(
          message: 'Não foi possível salvar as alterações.');
    }
  }
}
