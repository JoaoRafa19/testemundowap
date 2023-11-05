import 'package:testemundowap/adapters/repository/position/position.hive.repository.dart';
import 'package:testemundowap/adapters/repository/task/task.hive.repository.dart';
import 'package:testemundowap/adapters/repository/user/user.hive.repository.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/repositorys/position/i.position.repository.dart';
import 'package:testemundowap/domain/repositorys/tasks/i.task.respositoy.dart';
import 'package:testemundowap/domain/repositorys/user/i.user.repositor.dart';

class RepositoryFactory implements IRepositoryFactory {
  @override
  ITaskRepository get createTaskRepository => TaskHiveRepository.instance;

  @override
  IUserRepository get createUserRepository => UserGetStorageRepository.instance;

  @override
  IPositionRepository get createPositionRepository =>
      PositionHiveRepository.instance;
}
