import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/user.entity.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/repositorys/user/i.user.repositor.dart';

class FetchPersonalInformationUsecase {
  late IUserRepository _userRepository;

  FetchPersonalInformationUsecase(IRepositoryFactory repositoryFactory) {
    _userRepository = repositoryFactory.createUserRepository;
  }

  Future<User> execute() async {
    try {
      final user = await _userRepository.getUser();
      if (user == null) {
        throw Exception();
      }
      return user;
    } catch (e) {
      throw GetUserInformationException(
          message: 'Não foi possível obter os dados do usuário');
    }
  }
}
