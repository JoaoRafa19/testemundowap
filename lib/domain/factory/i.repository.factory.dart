import 'package:testemundowap/domain/repositorys/position/i.position.repository.dart';
import 'package:testemundowap/domain/repositorys/tasks/i.task.respositoy.dart';
import 'package:testemundowap/domain/repositorys/user/i.user.repositor.dart';

abstract class IRepositoryFactory {
  ITaskRepository get createTaskRepository;
  IUserRepository get createUserRepository;
  IPositionRepository get createPositionRepository;
}
