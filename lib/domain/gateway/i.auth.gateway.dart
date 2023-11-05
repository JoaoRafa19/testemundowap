import 'package:testemundowap/adapters/gateway/base.gatewat.dart';
import 'package:testemundowap/domain/dto/login/login.request.dto.dart';

abstract interface class IAuthGateway extends BaseGateway {
  IAuthGateway(super.baseUrl);

  Future<Map<String, dynamic>> login(LoginRequestDTO data);
  Future logOut();
}
