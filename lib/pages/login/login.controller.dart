import 'package:get/get.dart';
import 'package:testemundowap/adapters/factory/gateway.factory.dart';
import 'package:testemundowap/adapters/factory/repository.factory.dart';
import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/dto/login/login.request.dto.dart';
import 'package:testemundowap/domain/usecases/login.usecase.dart';
import 'package:testemundowap/pages/main/main.binding.dart';

class LoginController extends GetxController {
  final LoginUsecase _loginUsecase =
      LoginUsecase(GatewayFactory(), RepositoryFactory());

  Future login({required String email, required String password}) async {
    try {
      final LoginRequestDTO requestDTO =
          LoginRequestDTO(user: email, password: password);
      await _loginUsecase.execute(requestDTO);
      Get.toNamed(MainBinding.route);
    } catch (e) {
      if (e is InternalException) {
        Get.showSnackbar(GetSnackBar(
          message: e.message,
          title: "Erro",
        ));
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: "Aconteceu um erro inesperado",
          title: "Erro desconhecido",
        ));
      }
    }
  }
}
