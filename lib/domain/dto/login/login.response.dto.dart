import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/domain/entity/user.entity.dart';

class LoginResponseDTO {
  final bool success;
  final User? user;
  final List<Task> tasks;
  final String? errorMessage;

  LoginResponseDTO({
    required this.success,
    this.errorMessage,
    this.user,
    this.tasks = const [],
  });
}
