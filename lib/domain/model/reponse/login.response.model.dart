import 'package:testemundowap/domain/model/task.model.dart';
import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/dto/login/login.response.dto.dart';
import 'package:testemundowap/domain/model/user.model.dart';

class LoginResponseModel {
  static LoginResponseDTO fromJson(Map<String, dynamic> json) {
    var success = json["success"] as bool;
    if (success) {
      var user = UserModel.fromJsonToEntity(json["user"]);
      var tasks = TaskModel.fromJson(json["user"]["tasks"]);

      return LoginResponseDTO(success: success, tasks: tasks, user: user);
    } else {
      throw LoginResultExcetption(message: "Falha no login");
    }
  }
}
