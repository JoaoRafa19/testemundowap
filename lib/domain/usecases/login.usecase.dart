import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/dto/login/login.request.dto.dart';
import 'package:testemundowap/domain/factory/i.gateway.factory.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/gateway/i.auth.gateway.dart';
import 'package:testemundowap/domain/model/reponse/login.response.model.dart';
import 'package:testemundowap/domain/repositorys/tasks/i.task.respositoy.dart';
import 'package:testemundowap/domain/repositorys/user/i.user.repositor.dart';

class LoginUsecase {
  late IAuthGateway _authGateway;
  late IUserRepository _userRepository;
  late ITaskRepository _taskRepository;
  LoginUsecase(
    IGatewayFactory gatewayFactory,
    IRepositoryFactory repositoryFactory,
  ) {
    _authGateway = gatewayFactory.createAuthGateway;
    _taskRepository = repositoryFactory.createTaskRepository;
    _userRepository = repositoryFactory.createUserRepository;
  }

  Future<void> execute(LoginRequestDTO loginDTO) async {
    try {
      final response = await _authGateway.login(loginDTO);

      final responseDTO = LoginResponseModel.fromJson(response);
      if (responseDTO.success) {

        for (final task in responseDTO.tasks) {
          await _taskRepository.saveTask(task);
        }
        
        if (responseDTO.user == null) {
          throw LoginResultExcetption(message: "erro ao realizaro o login");
        }

        final user = await _userRepository.setUser(responseDTO.user!);
        if (user == null) {
          throw LoginResultExcetption(message: "Falha ao slavar usuário");
        }
        return;
      } else {
        throw LoginResultExcetption(message: "Login sem sucesso");
      }
    } on InternalException {
      rethrow;
    } catch (e) {
      throw LoginResultExcetption(
          message: "Falha inesperada ao realizar o login");
    }
  }
}
