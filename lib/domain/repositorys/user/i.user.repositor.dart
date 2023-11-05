import 'package:testemundowap/domain/entity/user.entity.dart';

abstract class IUserRepository {
  Future<User?> getUser();
  Future<User?> setUser(User user);
}
